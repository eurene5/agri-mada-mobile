// Repository local - Gestion des diagnostics dans Isar (hors-ligne)

import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';

import '../../../../core/ai/tflite_service.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/local_db/isar_service.dart';
import '../../../../core/local_db/models/diagnostic_local.dart';
import '../../domain/entities/diagnostic_result.dart' as domain;
import '../../domain/repositories/scan_repository.dart';

class DiagnosticLocalRepository implements ScanRepository {
  DiagnosticLocalRepository({TFLiteService? tfliteService})
      : _tfliteService = tfliteService ?? TFLiteService.instance;

  final TFLiteService _tfliteService;

  Isar get _db => IsarService.instance.db;

  // --- Lecture ---

  Future<List<DiagnosticLocal>> getDiagnosticsByParcelle(int parcelleLocalId) {
    return _db.diagnosticLocals
        .filter()
        .parcelleLocalIdEqualTo(parcelleLocalId)
        .sortByDateDiagnosticDesc()
        .findAll();
  }

  Future<List<DiagnosticLocal>> getAllDiagnostics() {
    return _db.diagnosticLocals.where().sortByDateDiagnosticDesc().findAll();
  }

  @override
  Future<Either<Failure, List<domain.DiagnosticResult>>> getAll() async {
    try {
      final diagnostics = await getAllDiagnostics();
      return Right(diagnostics.map(_toDomainEntity).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<DiagnosticLocal?> getLatestDiagnostic() {
    return _db.diagnosticLocals.where().sortByDateDiagnosticDesc().findFirst();
  }

  /// Récupère les diagnostics non encore synchronisés avec le serveur
  Future<List<DiagnosticLocal>> getUnsyncedDiagnostics() {
    return _db.diagnosticLocals.filter().isSyncedEqualTo(false).findAll();
  }

  @override
  Future<Either<Failure, domain.DiagnosticResult>> analyze(
    String imagePath,
  ) async {
    try {
      final result = await _tfliteService.analyzeImage(File(imagePath));
      return Right(
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
      return Left(ServerFailure(e.toString()));
    }
  }

  // --- Écriture ---

  Future<DiagnosticLocal> saveDiagnostic({
    required int parcelleLocalId,
    required String maladieDetectee,
    double? confiance,
    String? niveauGravite,
    String? recommandations,
    String? imagePath,
  }) async {
    final diagnostic = DiagnosticLocal()
      ..parcelleLocalId = parcelleLocalId
      ..maladieDetectee = maladieDetectee
      ..confiance = confiance
      ..niveauGravite = niveauGravite
      ..recommandations = recommandations
      ..imagePath = imagePath
      ..dateDiagnostic = DateTime.now()
      ..isSynced = false;

    await _db.writeTxn(() => _db.diagnosticLocals.put(diagnostic));
    return diagnostic;
  }

  @override
  Future<Either<Failure, Unit>> save(domain.DiagnosticResult result) async {
    final parcelleId = int.tryParse(result.parcelleId ?? '');
    if (parcelleId == null) {
      return const Left(ValidationFailure('Parcelle requise'));
    }

    try {
      await saveDiagnostic(
        parcelleLocalId: parcelleId,
        maladieDetectee: result.maladieDetectee,
        confiance: result.confiance,
        niveauGravite: result.niveauGravite,
        recommandations: result.recommandations.join(' | '),
        imagePath: result.imagePath,
      );
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<void> markAsSynced(int localId, int serverId) async {
    final diag = await _db.diagnosticLocals.get(localId);
    if (diag != null) {
      diag
        ..isSynced = true
        ..serverId = serverId;
      await _db.writeTxn(() => _db.diagnosticLocals.put(diag));
    }
  }

  Future<void> deleteDiagnostic(int id) async {
    await _db.writeTxn(() => _db.diagnosticLocals.delete(id));
  }

  domain.DiagnosticResult _toDomainEntity(DiagnosticLocal diagnostic) {
    return domain.DiagnosticResult(
      id: diagnostic.id.toString(),
      culture: 'Riz',
      maladieDetectee: diagnostic.maladieDetectee,
      confiance: diagnostic.confiance ?? 0,
      imagePath: diagnostic.imagePath,
      createdAt: diagnostic.dateDiagnostic,
      parcelleId: diagnostic.parcelleLocalId.toString(),
      niveauGravite: diagnostic.niveauGravite,
      recommandations: diagnostic.recommandations == null ||
              diagnostic.recommandations!.isEmpty
          ? const <String>[]
          : diagnostic.recommandations!
              .split(' | ')
              .where((item) => item.isNotEmpty)
              .toList(),
    );
  }
}
