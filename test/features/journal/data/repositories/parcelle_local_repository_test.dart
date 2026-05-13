import 'dart:io';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import 'package:agri_mada/core/local_db/models/diagnostic_local.dart';
import 'package:agri_mada/core/local_db/models/parcelle_local.dart';
import 'package:agri_mada/core/local_db/models/user_local.dart';
import 'package:agri_mada/core/local_db/isar_service.dart';
import 'package:agri_mada/features/journal/data/repositories/parcelle_local_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/path_provider');

  late ParcelleLocalRepository repository;

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
            await Directory.systemTemp.createTemp('agri_mada_test_');
        return tempDir.path;
      }
      return null;
    });
  });

  setUp(() async {
    await IsarService.instance.init();
    repository = ParcelleLocalRepository();
  });

  tearDown(() async {
    final db = IsarService.instance.db;
    await db.writeTxn(() async {
      await db.diagnosticLocals.clear();
      await db.parcelleLocals.clear();
      await db.userLocals.clear();
    });
    await IsarService.instance.close();
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('ParcelleLocalRepository', () {
    test('saveParcelle() persiste correctement', () async {
      // Arrange & Act
      final parcelle = await repository.createParcelle(
        nomParcelle: 'Riziere Nord',
        description: 'Parcelle de test',
        surface: 2.5,
      );

      // Assert
      expect(parcelle.id, greaterThan(0));
      expect(parcelle.nomParcelle, 'Riziere Nord');
      expect(parcelle.isSynced, isFalse);
    });

    test('getParcelles() retourne la liste locale', () async {
      // Arrange
      await repository.createParcelle(nomParcelle: 'Parcelle A');
      await repository.createParcelle(nomParcelle: 'Parcelle B');

      // Act
      final parcelles = await repository.getAllParcelles();

      // Assert
      expect(parcelles, hasLength(2));
      expect(parcelles.map((p) => p.nomParcelle),
          containsAll(['Parcelle A', 'Parcelle B']));
    });

    test('deleteParcelle() supprime l\'entree', () async {
      // Arrange
      final parcelle =
          await repository.createParcelle(nomParcelle: 'A supprimer');

      // Act
      await repository.deleteParcelle(parcelle.id.toString());
      final parcelles = await repository.getAllParcelles();

      // Assert
      expect(parcelles, isEmpty);
    });
  });
}
