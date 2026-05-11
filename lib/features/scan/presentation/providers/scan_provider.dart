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
  return ref.read(diagnosticRepositoryProvider).getDiagnosticsByParcelle(parcelleId);
});

/// Notifier principal du flux de scan
class ScanNotifier extends StateNotifier<AsyncValue<DiagnosticResult?>> {
  ScanNotifier(this._tflite, this._diagRepo)
      : super(const AsyncValue.data(null));

  final TFLiteService _tflite;
  final DiagnosticLocalRepository _diagRepo;

  /// Analyse une image et retourne le résultat
  Future<DiagnosticResult?> analyzeImage(File imageFile) async {
    state = const AsyncValue.loading();
    try {
      final result = await _tflite.analyzeImage(imageFile);
      state = AsyncValue.data(result);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
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

  void reset() => state = const AsyncValue.data(null);
}

final scanNotifierProvider =
    StateNotifierProvider<ScanNotifier, AsyncValue<DiagnosticResult?>>(
  (ref) => ScanNotifier(
    ref.read(tfliteServiceProvider),
    ref.read(diagnosticRepositoryProvider),
  ),
);
