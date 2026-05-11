// Repository local - Gestion des diagnostics dans Isar (hors-ligne)

import 'package:isar/isar.dart';
import '../../../core/local_db/isar_service.dart';
import '../../../core/local_db/models/diagnostic_local.dart';

class DiagnosticLocalRepository {
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
    return _db.diagnosticLocals
        .where()
        .sortByDateDiagnosticDesc()
        .findAll();
  }

  Future<DiagnosticLocal?> getLatestDiagnostic() {
    return _db.diagnosticLocals
        .where()
        .sortByDateDiagnosticDesc()
        .findFirst();
  }

  /// Récupère les diagnostics non encore synchronisés avec le serveur
  Future<List<DiagnosticLocal>> getUnsyncedDiagnostics() {
    return _db.diagnosticLocals.filter().isSyncedEqualTo(false).findAll();
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
}
