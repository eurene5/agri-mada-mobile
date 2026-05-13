// Service TFLite - Moteur d'intelligence artificielle hors-ligne
// Charge le modèle .tflite depuis les assets et effectue l'inférence
// directement sur le processeur du téléphone, sans connexion internet.
//
// Labels du modèle (labels.txt) :
//   0 → Bacterial leaf blight
//   1 → Brown spot
//   2 → Leaf smut

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../utils/logger.dart';

@visibleForTesting
bool hasValidTfliteModelHeader(Uint8List buffer) {
  if (buffer.length < 8) {
    return false;
  }

  return buffer[4] == 0x54 &&
      buffer[5] == 0x46 &&
      buffer[6] == 0x4C &&
      buffer[7] == 0x33;
}

class TFLiteNotInitializedException implements Exception {
  const TFLiteNotInitializedException();

  @override
  String toString() =>
      'TFLiteService non initialisé. Appelez init() avant analyzeImage().';
}

// Résultat d'une analyse IA
class DiagnosticResult {
  final String maladieDetectee;
  final double confiance;
  final String niveauGravite;
  final List<String> recommandations;

  const DiagnosticResult({
    required this.maladieDetectee,
    required this.confiance,
    required this.niveauGravite,
    required this.recommandations,
  });
}

class TFLiteService {
  TFLiteService._();
  static final TFLiteService instance = TFLiteService._();

  Interpreter? _interpreter;
  List<String> _labels = [];
  int? lastInferenceTimeMs;
  Future<void>? _initFuture;
  String? _lastInitError;

  // Taille d'entrée du modèle (doit correspondre au modèle entraîné)
  static const int _inputSize = 224;

  bool get isReady => _interpreter != null && _labels.isNotEmpty;

  String? get lastInitError => _lastInitError;

  /// À appeler une seule fois dans main() après IsarService.init()
  Future<void> init() {
    if (isReady) return Future<void>.value();
    return _initFuture ??= _doInit();
  }

  Future<void> _doInit() async {
    try {
      AppLogger.info('TFLite init: chargement du modele...');
      final modelData =
          await rootBundle.load('assets/model/agrimada_model.tflite');

      if (modelData.lengthInBytes == 0) {
        throw Exception('Fichier modele IA vide');
      }

      final buffer = modelData.buffer.asUint8List();
      if (!hasValidTfliteModelHeader(buffer)) {
        throw Exception(
          'Fichier modele IA invalide: signature TFLite absente',
        );
      }

      AppLogger.debug('TFLite model bytes: ${buffer.length}');
      final options = InterpreterOptions()..threads = 4;
      _interpreter = Interpreter.fromBuffer(buffer, options: options);

      AppLogger.info('TFLite init: chargement des labels...');
      final labelsData = await rootBundle.loadString('assets/model/labels.txt');
      _labels = labelsData
          .split('\n')
          .map((l) => l.trim())
          .where((l) => l.isNotEmpty)
          .toList();

      if (_labels.isEmpty) {
        throw Exception('Fichier labels vide ou invalide');
      }

      _lastInitError = null;
      AppLogger.info('TFLite init: ok (${_labels.length} labels)');
    } catch (e, st) {
      _interpreter?.close();
      _interpreter = null;
      _labels = [];
      _lastInitError = e.toString();
      AppLogger.error(
        'Initialisation TFLite echouee',
        error: e,
        stackTrace: st,
      );
      rethrow;
    } finally {
      _initFuture = null;
    }
  }

  /// Analyse une image et retourne le diagnostic
  Future<DiagnosticResult> analyzeImage(File imageFile) async {
    if (!isReady) {
      throw const TFLiteNotInitializedException();
    }

    final stopwatch = Stopwatch()..start();

    // 1. Lire et redimensionner l'image
    final bytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(bytes);
    if (originalImage == null) throw Exception('Image invalide');

    final resized = img.copyResize(
      originalImage,
      width: _inputSize,
      height: _inputSize,
    );

    // 2. Convertir en Float32List normalisé (valeurs entre 0.0 et 1.0)
    final inputData = _imageToFloat32(resized);

    // 3. Préparer la sortie
    final output = List.filled(_labels.length, 0.0);
    final outputList = [output]; // Envelopper en liste 2D pour l'inférence

    // 4. Inférence
    _interpreter!.run([inputData], outputList);

    // 5. Trouver le label avec le score le plus élevé
    final scores = outputList[0];
    double maxScore = 0;
    int maxIndex = 0;
    for (int i = 0; i < scores.length; i++) {
      if (scores[i] > maxScore) {
        maxScore = scores[i];
        maxIndex = i;
      }
    }

    final maladie = maxIndex < _labels.length ? _labels[maxIndex] : 'Inconnu';
    final gravite = _determineGravite(maladie, maxScore);
    final recommandations = _getRecommandations(maladie);

    stopwatch.stop();
    lastInferenceTimeMs = stopwatch.elapsedMilliseconds;

    return DiagnosticResult(
      maladieDetectee: maladie,
      confiance: maxScore,
      niveauGravite: gravite,
      recommandations: recommandations,
    );
  }

  /// Détermine le niveau de gravité basé sur la maladie et le score
  String _determineGravite(String maladie, double confiance) {
    if (maladie.toLowerCase() == 'healthy') return 'aucune';
    if (confiance >= 0.85) return 'sévère';
    if (confiance >= 0.60) return 'modéré';
    return 'faible';
  }

  /// Retourne les identifiants de clés ARB des recommandations pour un type de maladie.
  /// La résolution en chaînes localisées est effectuée dans la couche présentation.
  List<String> _getRecommandations(String maladie) {
    return switch (maladie) {
      'Bacterial leaf blight' => [
          'scanRecBlbEvacuateWater',
          'scanRecBlbApplyCopper',
          'scanRecBlbAvoidNitrogen',
          'scanRecBlbUseResistantVarieties',
        ],
      'Brown spot' => [
          'scanRecBrownSpotFertilize',
          'scanRecBrownSpotApplyFungicide',
          'scanRecBrownSpotDrainage',
          'scanRecBrownSpotAvoidStress',
        ],
      'Leaf smut' => [
          'scanRecLeafSmutTreatSeeds',
          'scanRecLeafSmutApplyFungicide',
          'scanRecLeafSmutRemovePlants',
          'scanRecLeafSmutRotation',
        ],
      _ => ['scanRecHealthy'],
    };
  }

  /// Convertit une image redimensionnée en Float32 normalisé
  List<List<List<List<double>>>> _imageToFloat32(img.Image image) {
    return List.generate(1, (_) {
      return List.generate(_inputSize, (y) {
        return List.generate(_inputSize, (x) {
          final pixel = image.getPixel(x, y);
          return [
            pixel.rNormalized.toDouble(),
            pixel.gNormalized.toDouble(),
            pixel.bNormalized.toDouble(),
          ];
        });
      });
    });
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _labels = [];
    _lastInitError = null;
  }
}
