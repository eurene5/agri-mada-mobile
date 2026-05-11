// Repository local - Gestion des parcelles dans Isar (hors-ligne)

import 'package:isar/isar.dart';
import '../../../core/local_db/isar_service.dart';
import '../../../core/local_db/models/parcelle_local.dart';
import '../../../core/local_db/models/diagnostic_local.dart';

class ParcelleLocalRepository {
  Isar get _db => IsarService.instance.db;

  // --- Lecture ---

  Future<List<ParcelleLocal>> getAllParcelles() {
    return _db.parcelleLocals.where().findAll();
  }

  Future<ParcelleLocal?> getParcelleById(int id) {
    return _db.parcelleLocals.get(id);
  }

  /// Récupère les parcelles non encore synchronisées avec le serveur
  Future<List<ParcelleLocal>> getUnsyncedParcelles() {
    return _db.parcelleLocals.filter().isSyncedEqualTo(false).findAll();
  }

  // --- Écriture ---

  Future<ParcelleLocal> createParcelle({
    required String nomParcelle,
    String? description,
    double? surface,
    double? latitude,
    double? longitude,
  }) async {
    final parcelle = ParcelleLocal()
      ..nomParcelle = nomParcelle
      ..description = description
      ..surface = surface
      ..latitude = latitude
      ..longitude = longitude
      ..createdAt = DateTime.now()
      ..isSynced = false;

    await _db.writeTxn(() => _db.parcelleLocals.put(parcelle));
    return parcelle;
  }

  Future<void> markAsSynced(int localId, int serverId) async {
    final parcelle = await _db.parcelleLocals.get(localId);
    if (parcelle != null) {
      parcelle
        ..isSynced = true
        ..serverId = serverId;
      await _db.writeTxn(() => _db.parcelleLocals.put(parcelle));
    }
  }

  Future<void> deleteParcelle(int id) async {
    await _db.writeTxn(() => _db.parcelleLocals.delete(id));
  }

  /// Construit le journal agricole : chaque parcelle avec son statut de santé
  Future<List<Map<String, dynamic>>> getJournalAgricole() async {
    final parcelles = await getAllParcelles();
    final journal = <Map<String, dynamic>>[];

    for (final parcelle in parcelles) {
      // Récupère le dernier diagnostic de cette parcelle
      final diagnostics = await _db.diagnosticLocals
          .filter()
          .parcelleLocalIdEqualTo(parcelle.id)
          .sortByDateDiagnosticDesc()
          .findAll();

      final nb = diagnostics.length;
      final dernierDiag = nb > 0 ? diagnostics.first : null;
      final derniereMaladie = dernierDiag?.maladieDetectee;
      final statut = nb == 0
          ? 'aucun_diagnostic'
          : (derniereMaladie?.toLowerCase() == 'healthy' ? 'sain' : 'malade');

      journal.add({
        'parcelle': parcelle,
        'nb_diagnostics': nb,
        'derniere_maladie': derniereMaladie,
        'dernier_diagnostic': dernierDiag,
        'statut': statut,
      });
    }

    return journal;
  }
}
