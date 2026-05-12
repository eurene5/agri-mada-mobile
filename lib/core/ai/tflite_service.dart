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
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

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

  // Taille d'entrée du modèle (doit correspondre au modèle entraîné)
  static const int _inputSize = 224;

  /// À appeler une seule fois dans main() après IsarService.init()
  Future<void> init() async {
    // Charger le modèle
    final modelData =
        await rootBundle.load('assets/model/agrimada_model.tflite');
    final buffer = modelData.buffer.asUint8List();
    _interpreter = Interpreter.fromBuffer(buffer);

    // Charger les labels
    final labelsData = await rootBundle.loadString('assets/model/labels.txt');
    _labels = labelsData
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
  }

  /// Analyse une image et retourne le diagnostic
  Future<DiagnosticResult> analyzeImage(File imageFile) async {
    if (_interpreter == null) {
      throw StateError(
          'TFLiteService non initialisé. Appelez init() d\'abord.');
    }

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

  /// Recommandations agricoles par type de maladie
  List<String> _getRecommandations(String maladie) {
    return switch (maladie) {
      'Bacterial leaf blight' => [
          'Évacuer l\'eau des rizières infectées',
          'Appliquer du cuivre hydroxyde (2-3 g/L)',
          'Éviter l\'excès d\'azote',
          'Utiliser des variétés résistantes lors du prochain cycle',
        ],
      'Brown spot' => [
          'Améliorer la fertilisation (potassium)',
          'Appliquer un fongicide à base de mancozèbe',
          'Assurer un drainage correct',
          'Éviter le stress hydrique',
        ],
      'Leaf smut' => [
          'Traiter les semences avant plantation',
          'Appliquer des fongicides systémiques',
          'Retirer et brûler les plants infectés',
          'Rotation des cultures recommandée',
        ],
      _ => ['Plante en bonne santé. Continuez les bonnes pratiques agricoles.'],
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
  }
}
