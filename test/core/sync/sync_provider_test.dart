import 'dart:io';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/local_db/models/diagnostic_local.dart';
import 'package:agri_mada/core/local_db/isar_service.dart';
import 'package:agri_mada/core/local_db/models/parcelle_local.dart';
import 'package:agri_mada/core/local_db/models/user_local.dart';
import 'package:agri_mada/core/sync/data/datasources/sync_remote_datasource.dart';
import 'package:agri_mada/core/sync/providers/sync_provider.dart';
import 'package:agri_mada/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:agri_mada/features/auth/presentation/providers/auth_provider.dart';
import 'package:agri_mada/features/journal/data/repositories/parcelle_local_repository.dart';

class MockSyncRemoteDatasource extends Mock implements SyncRemoteDatasource {}

class MockAuthRepositoryImpl extends Mock implements AuthRepositoryImpl {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/path_provider');

  late ProviderContainer container;
  late MockSyncRemoteDatasource mockSyncRemoteDatasource;
  late MockAuthRepositoryImpl mockAuthRepository;

  setUpAll(() async {
    await Isar.initializeIsarCore(
      libraries: {
        Abi.windowsX64:
            'C:/Users/dilan/AppData/Local/Pub/Cache/hosted/pub.dev/isar_flutter_libs-3.1.0+1/windows/isar.dll',
      },
    );

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        final tempDir =
            await Directory.systemTemp.createTemp('agri_mada_sync_');
        return tempDir.path;
      }
      return null;
    });
  });

  setUp(() async {
    await IsarService.instance.init();

    mockSyncRemoteDatasource = MockSyncRemoteDatasource();
    mockAuthRepository = MockAuthRepositoryImpl();

    when(() => mockAuthRepository.logout()).thenAnswer(
      (_) async => const Right(unit),
    );

    container = ProviderContainer(
      overrides: [
        syncRemoteDatasourceProvider
            .overrideWithValue(mockSyncRemoteDatasource),
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
      ],
    );
  });

  tearDown(() async {
    final db = IsarService.instance.db;
    await db.writeTxn(() async {
      await db.diagnosticLocals.clear();
      await db.parcelleLocals.clear();
      await db.userLocals.clear();
    });
    await IsarService.instance.close();
    container.dispose();
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('SyncNotifier', () {
    test('sync reussie -> SyncState.success()', () async {
      // Arrange
      when(() => mockSyncRemoteDatasource.syncParcelles(any())).thenAnswer(
        (_) async => {'parcelles_creees': <Map<String, dynamic>>[]},
      );
      when(() => mockSyncRemoteDatasource.syncDiagnostics(any())).thenAnswer(
        (_) async => {'diagnostics_crees': <Map<String, dynamic>>[]},
      );

      // Act
      await container.read(syncNotifierProvider.notifier).syncData();

      // Assert
      expect(container.read(syncNotifierProvider), const SyncState.success());
    });

    test(
        '401 -> declenche logout + SyncState.error("Session expiree, veuillez vous reconnecter")',
        () async {
      // Arrange
      final parcelleRepo = ParcelleLocalRepository();
      await parcelleRepo.createParcelle(nomParcelle: 'Parcelle 401');

      when(() => mockSyncRemoteDatasource.syncParcelles(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/sync/parcelles'),
          response: Response(
            requestOptions: RequestOptions(path: '/sync/parcelles'),
            statusCode: 401,
          ),
        ),
      );

      // Act
      await container.read(syncNotifierProvider.notifier).syncData();

      // Assert
      expect(
        container.read(syncNotifierProvider),
        const SyncState.error('Session expirée, veuillez vous reconnecter'),
      );
      verify(() => mockAuthRepository.logout()).called(1);
    });

    test(
        'timeout -> retry 2 fois puis SyncState.error("Erreur de synchronisation")',
        () async {
      // Arrange
      final parcelleRepo = ParcelleLocalRepository();
      await parcelleRepo.createParcelle(nomParcelle: 'Parcelle timeout');

      when(() => mockSyncRemoteDatasource.syncParcelles(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/sync/parcelles'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      // Act
      await container.read(syncNotifierProvider.notifier).syncData();

      // Assert
      verify(() => mockSyncRemoteDatasource.syncParcelles(any())).called(2);
      expect(
        container.read(syncNotifierProvider),
        const SyncState.error('Erreur de synchronisation'),
      );
    });

    test(
        'token absent (401) -> SyncState.error("Session expirée, veuillez vous reconnecter")',
        () async {
      // Arrange
      final parcelleRepo = ParcelleLocalRepository();
      await parcelleRepo.createParcelle(nomParcelle: 'Parcelle token absent');

      when(() => mockSyncRemoteDatasource.syncParcelles(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/sync/parcelles'),
          response: Response(
            requestOptions: RequestOptions(path: '/sync/parcelles'),
            statusCode: 401,
          ),
        ),
      );

      // Act
      await container.read(syncNotifierProvider.notifier).syncData();

      // Assert
      expect(
        container.read(syncNotifierProvider),
        const SyncState.error('Session expirée, veuillez vous reconnecter'),
      );
    });
  });
}
