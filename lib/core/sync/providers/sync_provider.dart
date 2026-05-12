import 'dart:async';

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/failure.dart';
import '../../../core/utils/logger.dart';
import '../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../features/journal/data/repositories/parcelle_local_repository.dart';
import '../../../features/scan/data/repositories/diagnostic_local_repository.dart';
import '../data/datasources/sync_remote_datasource.dart';

part 'sync_provider.g.dart';

sealed class SyncState {
  const SyncState();

  const factory SyncState.idle() = SyncIdle;
  const factory SyncState.syncing() = SyncSyncing;
  const factory SyncState.success() = SyncSuccess;
  const factory SyncState.error(String message) = SyncError;
}

class SyncIdle extends SyncState {
  const SyncIdle();
}

class SyncSyncing extends SyncState {
  const SyncSyncing();
}

class SyncSuccess extends SyncState {
  const SyncSuccess();
}

class SyncError extends SyncState {
  const SyncError(this.message);

  final String message;
}

@riverpod
SyncRemoteDatasource syncRemoteDatasource(Ref ref) {
  return SyncRemoteDatasource(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
class SyncNotifier extends _$SyncNotifier {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  static const int _maxAttempts = 2;

  @override
  SyncState build() {
    _initConnectivityListener();
    ref.onDispose(() => _connectivitySubscription?.cancel());
    return const SyncState.idle();
  }

  void _initConnectivityListener() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((results) {
      if (results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi)) {
        syncData();
      }
    });
  }

  Future<void> syncData() async {
    if (state is SyncSyncing) return;
    state = const SyncState.syncing();

    for (var attempt = 1; attempt <= _maxAttempts; attempt++) {
      try {
        await _syncParcellesAndDiagnostics();
        state = const SyncState.success();
        return;
      } on DioException catch (e, st) {
        final isUnauthorized =
            e.response?.statusCode == 401 || e.error is AuthFailure;
        if (isUnauthorized) {
          AppLogger.error(
            'Synchronisation interrompue: session expirée',
            error: e.error ?? e,
            stackTrace: st,
          );
          await ref.read(authNotifierProvider.notifier).logout();
          state = const SyncState.error(
            'Session expirée, veuillez vous reconnecter',
          );
          return;
        }

        AppLogger.error(
          'Tentative de synchronisation échouée',
          error: e,
          stackTrace: st,
        );

        if (attempt == _maxAttempts) {
          state = const SyncState.error('Erreur de synchronisation');
          return;
        }
      } catch (e, st) {
        AppLogger.error(
          'Erreur inattendue de synchronisation',
          error: e,
          stackTrace: st,
        );

        if (attempt == _maxAttempts) {
          state = const SyncState.error('Erreur de synchronisation');
          return;
        }
      }
    }
  }

  Future<void> _syncParcellesAndDiagnostics() async {
    final parcelleRepo = ParcelleLocalRepository();
    final diagnosticRepo = DiagnosticLocalRepository();
    final remoteDataSource = ref.read(syncRemoteDatasourceProvider);

    final unsyncedParcelles = await parcelleRepo.getUnsyncedParcelles();
    if (unsyncedParcelles.isNotEmpty) {
      final payload = {
        'parcelles': unsyncedParcelles
            .map((p) => {
                  'nom_parcelle': p.nomParcelle,
                  'description': p.description,
                  'surface': p.surface,
                  'latitude': p.latitude,
                  'longitude': p.longitude,
                })
            .toList(),
      };

      final response = await remoteDataSource.syncParcelles(payload);
      final createdList = response['parcelles_creees'] as List<dynamic>;

      for (int index = 0; index < unsyncedParcelles.length; index++) {
        final createdParcelle = createdList[index] as Map<String, dynamic>;
        final serverId = createdParcelle['id'] as int;
        await parcelleRepo.markAsSynced(unsyncedParcelles[index].id, serverId);
      }
    }

    final unsyncedDiagnostics = await diagnosticRepo.getUnsyncedDiagnostics();
    if (unsyncedDiagnostics.isEmpty) {
      return;
    }

    final payloadDiagnostics = <Map<String, dynamic>>[];
    final localDiagIds = <int>[];

    for (final diag in unsyncedDiagnostics) {
      final parcelle = await parcelleRepo.getParcelleById(diag.parcelleLocalId);
      if (parcelle != null && parcelle.serverId != null) {
        payloadDiagnostics.add({
          'parcelle_id': parcelle.serverId,
          'maladie_detectee': diag.maladieDetectee,
          'confiance': diag.confiance,
          'niveau_gravite': diag.niveauGravite,
          'recommandations': diag.recommandations,
          'date_diagnostic': diag.dateDiagnostic.toIso8601String(),
        });
        localDiagIds.add(diag.id);
      }
    }

    if (payloadDiagnostics.isEmpty) {
      return;
    }

    final response = await remoteDataSource.syncDiagnostics(
      {'diagnostics': payloadDiagnostics},
    );
    final createdList = response['diagnostics_crees'] as List<dynamic>;

    for (int index = 0; index < localDiagIds.length; index++) {
      if (index < createdList.length) {
        final createdDiagnostic = createdList[index] as Map<String, dynamic>;
        final serverId = createdDiagnostic['id'] as int;
        await diagnosticRepo.markAsSynced(localDiagIds[index], serverId);
      }
    }
  }
}
