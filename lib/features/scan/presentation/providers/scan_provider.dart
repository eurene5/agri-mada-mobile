// Providers Riverpod pour le scan IA et la gestion des diagnostics

import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ai/tflite_service.dart';
import '../../../../core/local_db/models/diagnostic_local.dart';
import '../../data/repositories/diagnostic_local_repository.dart';

// Le résultat du dernier diagnostic
final lastDiagnosticResultProvider =
    StateProvider<DiagnosticResult?>((ref) => null);

/// Accès au repository des diagnostics
final diagnosticRepositoryProvider = Provider<DiagnosticLocalRepository>(
  (_) => DiagnosticLocalRepository(),
);

/// Accès au service TFLite
final tfliteServiceProvider = Provider<TFLiteService>(
  (_) => TFLiteService.instance,
);

/// Diagnostics d'une parcelle donnée
final diagnosticsParParcelleProvider =
    FutureProvider.family<List<DiagnosticLocal>, int>((ref, parcelleId) async {
  return ref
      .read(diagnosticRepositoryProvider)
      .getDiagnosticsByParcelle(parcelleId);
});

sealed class ScanState {
  const ScanState();

  const factory ScanState.initial() = ScanInitial;
  const factory ScanState.loading() = ScanLoading;
  const factory ScanState.success(DiagnosticResult result) = ScanSuccess;
  const factory ScanState.error(String message) = ScanError;
}

class ScanInitial extends ScanState {
  const ScanInitial();
}

class ScanLoading extends ScanState {
  const ScanLoading();
}

class ScanSuccess extends ScanState {
  const ScanSuccess(this.result);

  final DiagnosticResult result;
}

class ScanError extends ScanState {
  const ScanError(this.message);

  final String message;
}

/// Notifier principal du flux de scan
class ScanNotifier extends StateNotifier<ScanState> {
  ScanNotifier(this._tflite, this._diagRepo) : super(const ScanState.initial());

  final TFLiteService _tflite;
  final DiagnosticLocalRepository _diagRepo;

  /// Analyse une image et retourne le résultat
  Future<DiagnosticResult?> analyzeImage(File imageFile) async {
    if (!_tflite.isReady) {
      state = const ScanState.error('Moteur IA non disponible');
      return null;
    }

    state = const ScanState.loading();
    try {
      final result = await _tflite.analyzeImage(imageFile);
      state = ScanState.success(result);
      return result;
    } on TFLiteNotInitializedException {
      state = const ScanState.error('Moteur IA non disponible');
      return null;
    } catch (_) {
      state = const ScanState.error('Erreur pendant le diagnostic IA');
      return null;
    }
  }

  /// Sauvegarde le diagnostic dans Isar (hors-ligne)
  Future<DiagnosticLocal?> saveDiagnostic({
    required int parcelleLocalId,
    required DiagnosticResult result,
    String? imagePath,
  }) async {
    try {
      return await _diagRepo.saveDiagnostic(
        parcelleLocalId: parcelleLocalId,
        maladieDetectee: result.maladieDetectee,
        confiance: result.confiance,
        niveauGravite: result.niveauGravite,
        recommandations: result.recommandations.join(' | '),
        imagePath: imagePath,
      );
    } catch (_) {
      return null;
    }
  }

  void reset() => state = const ScanState.initial();
}

final scanNotifierProvider = StateNotifierProvider<ScanNotifier, ScanState>(
  (ref) => ScanNotifier(
    ref.read(tfliteServiceProvider),
    ref.read(diagnosticRepositoryProvider),
  ),
);
