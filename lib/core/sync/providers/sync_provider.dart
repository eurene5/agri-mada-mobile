import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../features/journal/data/repositories/parcelle_local_repository.dart';
import '../../../features/scan/data/repositories/diagnostic_local_repository.dart';
import '../data/datasources/sync_remote_datasource.dart';

part 'sync_provider.g.dart';

@riverpod
SyncRemoteDatasource syncRemoteDatasource(Ref ref) {
  return SyncRemoteDatasource(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
class SyncNotifier extends _$SyncNotifier {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  bool build() {
    _initConnectivityListener();
    return false; // isSyncing
  }

  void _initConnectivityListener() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((results) {
      if (results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi)) {
        syncData();
      }
    });
  }

  Future<void> syncData() async {
    if (state) return; // Déjà en cours de synchronisation
    state = true;

    try {
      final parcelleRepo = ParcelleLocalRepository();
      final diagnosticRepo = DiagnosticLocalRepository();
      final remoteDataSource = ref.read(syncRemoteDatasourceProvider);

      // 1. Synchroniser les parcelles
      final unsyncedParcelles = await parcelleRepo.getUnsyncedParcelles();
      if (unsyncedParcelles.isNotEmpty) {
        final payload = {
          "parcelles": unsyncedParcelles.map((p) => {
            "nom_parcelle": p.nomParcelle,
            "description": p.description,
            "surface": p.surface,
            "latitude": p.latitude,
            "longitude": p.longitude,
          }).toList(),
        };

        final response = await remoteDataSource.syncParcelles(payload);
        final createdList = response['parcelles_creees'] as List<dynamic>;

        // Mettre à jour les ID locaux avec les ID serveurs (ils sont dans le même ordre)
        for (int i = 0; i < unsyncedParcelles.length; i++) {
          final serverId = createdList[i]['id'] as int;
          await parcelleRepo.markAsSynced(unsyncedParcelles[i].id, serverId);
        }
      }

      // 2. Synchroniser les diagnostics
      final unsyncedDiagnostics = await diagnosticRepo.getUnsyncedDiagnostics();
      if (unsyncedDiagnostics.isNotEmpty) {
        final List<Map<String, dynamic>> payloadDiagnostics = [];
        final List<int> localDiagIds = [];

        for (final diag in unsyncedDiagnostics) {
          final parcelle = await parcelleRepo.getParcelleById(diag.parcelleLocalId);
          if (parcelle != null && parcelle.serverId != null) {
            payloadDiagnostics.add({
              "parcelle_id": parcelle.serverId,
              "maladie_detectee": diag.maladieDetectee,
              "confiance": diag.confiance,
              "niveau_gravite": diag.niveauGravite,
              "recommandations": diag.recommandations,
              "date_diagnostic": diag.dateDiagnostic.toIso8601String(),
            });
            localDiagIds.add(diag.id);
          }
        }

        if (payloadDiagnostics.isNotEmpty) {
          final response = await remoteDataSource.syncDiagnostics({"diagnostics": payloadDiagnostics});
          final createdList = response['diagnostics_crees'] as List<dynamic>;

          for (int i = 0; i < localDiagIds.length; i++) {
            if (i < createdList.length) {
                final serverId = createdList[i]['id'] as int;
                await diagnosticRepo.markAsSynced(localDiagIds[i], serverId);
            }
          }
        }
      }
    } catch (e) {
      // Ignorer l'erreur, la synchronisation réessayera plus tard
      print("Erreur de synchronisation: $e");
    } finally {
      state = false;
    }
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
