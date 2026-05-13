// Providers Riverpod pour le scan IA et la gestion des diagnostics

import 'dart:io';

import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ai/tflite_service.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/local_db/models/diagnostic_local.dart';
import '../../data/repositories/diagnostic_local_repository.dart';
import '../../domain/entities/diagnostic_result.dart' as domain;
import '../../domain/repositories/scan_repository.dart';
import '../../domain/usecases/analyze_image_usecase.dart';

// Le résultat du dernier diagnostic
final lastDiagnosticResultProvider =
    StateProvider<DiagnosticResult?>((ref) => null);

/// Accès au repository des diagnostics
final diagnosticRepositoryProvider = Provider<DiagnosticLocalRepository>(
  (_) => DiagnosticLocalRepository(),
);

/// Accès au service TFLite pour compatibilité des tests existants.
final tfliteServiceProvider = Provider<TFLiteService>(
  (_) => TFLiteService.instance,
);

/// Contrat domain du scan
final scanRepositoryProvider = Provider<ScanRepository>(
  (ref) => _ScanRepositoryAdapter(
    ref.watch(tfliteServiceProvider),
    ref.watch(diagnosticRepositoryProvider),
  ),
);

/// Use case d'analyse d'image
final analyzeImageUseCaseProvider = Provider<AnalyzeImageUseCase>(
  (ref) => AnalyzeImageUseCase(ref.watch(scanRepositoryProvider)),
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
  const factory ScanState.engineUnavailable(String message) =
      ScanEngineUnavailable;
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

class ScanEngineUnavailable extends ScanState {
  const ScanEngineUnavailable(this.message);

  final String message;
}

class ScanError extends ScanState {
  const ScanError(this.message);

  final String message;
}

/// Notifier principal du flux de scan
class ScanNotifier extends StateNotifier<ScanState> {
  ScanNotifier(this._analyzeImage, this._scanRepository, this._diagRepo)
      : super(const ScanState.initial());

  final AnalyzeImageUseCase _analyzeImage;
  final ScanRepository _scanRepository;
  final DiagnosticLocalRepository _diagRepo;
  int? _lastParcelleLocalId;
  DiagnosticResult? _lastDiagnosticResult;
  domain.DiagnosticResult? _lastDomainDiagnosticResult;
  DiagnosticLocal? _lastSavedDiagnostic;

  int? get lastParcelleLocalId => _lastParcelleLocalId;

  DiagnosticResult? get lastDiagnosticResult => _lastDiagnosticResult;

  DiagnosticLocal? get lastSavedDiagnostic => _lastSavedDiagnostic;

  /// Analyse une image et retourne le résultat
  Future<DiagnosticResult?> analyzeImage(File imageFile) async {
    state = const ScanState.loading();
    final result = await _analyzeImage(imageFile.path);

    return result.fold((failure) {
      state = switch (failure) {
        ValidationFailure() => ScanState.error(failure.message),
        NetworkFailure() =>
          const ScanState.engineUnavailable('Moteur IA non disponible'),
        _ => const ScanState.error('Erreur pendant le diagnostic IA'),
      };
      return null;
    }, (diagnostic) {
      _lastDomainDiagnosticResult = diagnostic;
      final mappedResult = _scanRepository is _ScanRepositoryAdapter
          ? (_scanRepository as _ScanRepositoryAdapter).lastRawResult ??
              DiagnosticResult(
                maladieDetectee: diagnostic.maladieDetectee,
                confiance: diagnostic.confiance,
                niveauGravite: diagnostic.niveauGravite ?? '',
                recommandations: diagnostic.recommandations,
              )
          : DiagnosticResult(
              maladieDetectee: diagnostic.maladieDetectee,
              confiance: diagnostic.confiance,
              niveauGravite: diagnostic.niveauGravite ?? '',
              recommandations: diagnostic.recommandations,
            );
      _lastDiagnosticResult = mappedResult;
      state = ScanState.success(mappedResult);
      return mappedResult;
    });
  }

  /// Sauvegarde le diagnostic dans Isar (hors-ligne)
  Future<DiagnosticLocal?> saveDiagnostic({
    int? parcelleLocalId,
    required DiagnosticResult result,
    String? imagePath,
  }) async {
    try {
      final resolvedParcelleLocalId = parcelleLocalId ?? _lastParcelleLocalId;
      if (resolvedParcelleLocalId == null) {
        return null;
      }

      final saveResult = await _scanRepository.save(
        _toDomainResult(
          result,
          imagePath: imagePath ?? _lastDomainDiagnosticResult?.imagePath,
        ).copyWith(
          parcelleId: resolvedParcelleLocalId.toString(),
        ),
      );

      return await saveResult.fold(
        (_) async => null,
        (_) async => _diagRepo.getLatestDiagnostic().then((diagnostic) {
          if (diagnostic == null) {
            return null;
          }
          _lastParcelleLocalId = resolvedParcelleLocalId;
          _lastDiagnosticResult = result;
          _lastDomainDiagnosticResult = _toDomainResult(
            result,
            imagePath: imagePath ?? _lastDomainDiagnosticResult?.imagePath,
          ).copyWith(
            parcelleId: resolvedParcelleLocalId.toString(),
          );
          _lastSavedDiagnostic = diagnostic;
          return diagnostic;
        }),
      );
    } catch (_) {
      return null;
    }
  }

  Future<DiagnosticLocal?> persistLastDiagnostic({String? imagePath}) async {
    final existingSavedDiagnostic = _lastSavedDiagnostic;
    if (existingSavedDiagnostic != null) {
      return existingSavedDiagnostic;
    }

    final result = switch (state) {
      ScanSuccess(:final result) => result,
      _ => _lastDiagnosticResult,
    };

    if (result == null) {
      return null;
    }

    return saveDiagnostic(
      parcelleLocalId: _lastParcelleLocalId,
      result: result,
      imagePath: imagePath,
    );
  }

  void reset() {
    _lastParcelleLocalId = null;
    _lastDiagnosticResult = null;
    _lastDomainDiagnosticResult = null;
    _lastSavedDiagnostic = null;
    state = const ScanState.initial();
  }

  domain.DiagnosticResult _toDomainResult(
    DiagnosticResult result, {
    String? imagePath,
  }) {
    return _lastDomainDiagnosticResult ??
        domain.DiagnosticResult(
          culture: 'Riz',
          maladieDetectee: result.maladieDetectee,
          confiance: result.confiance,
          imagePath: imagePath ?? _lastDomainDiagnosticResult?.imagePath,
          createdAt: DateTime.now(),
          niveauGravite:
              result.niveauGravite.isEmpty ? null : result.niveauGravite,
          recommandations: result.recommandations,
        );
  }
}

class _ScanRepositoryAdapter implements ScanRepository {
  _ScanRepositoryAdapter(this._tfliteService, this._repository);

  final TFLiteService _tfliteService;
  final DiagnosticLocalRepository _repository;
  DiagnosticResult? _lastRawResult;

  DiagnosticResult? get lastRawResult => _lastRawResult;

  @override
  Future<fpdart.Either<Failure, domain.DiagnosticResult>> analyze(
    String imagePath,
  ) async {
    if (!_tfliteService.isReady) {
      return const fpdart.Left(NetworkFailure('Moteur IA non disponible'));
    }

    try {
      final result = await _tfliteService.analyzeImage(File(imagePath));
      _lastRawResult = result;
      return fpdart.Right(
        domain.DiagnosticResult(
          culture: 'Riz',
          maladieDetectee: result.maladieDetectee,
          confiance: result.confiance,
          imagePath: imagePath,
          createdAt: DateTime.now(),
          niveauGravite: result.niveauGravite,
          recommandations: result.recommandations,
        ),
      );
    } catch (e) {
      return fpdart.Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<fpdart.Either<Failure, List<domain.DiagnosticResult>>> getAll() {
    return _repository.getAll();
  }

  @override
  Future<fpdart.Either<Failure, fpdart.Unit>> save(
    domain.DiagnosticResult result,
  ) {
    return _repository.save(result);
  }
}

final scanNotifierProvider = StateNotifierProvider<ScanNotifier, ScanState>(
  (ref) => ScanNotifier(
    ref.read(analyzeImageUseCaseProvider),
    ref.read(scanRepositoryProvider),
    ref.read(diagnosticRepositoryProvider),
  ),
);
