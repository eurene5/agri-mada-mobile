import 'package:agri_mada/core/sync/providers/sync_provider.dart';
import 'package:agri_mada/features/home/presentation/screens/home_screen.dart';
import 'package:agri_mada/features/scan/presentation/screens/scan_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';

import 'helpers/app_helper.dart';
import 'helpers/mock_image_picker.dart';
import 'helpers/mock_sync_remote_datasource.dart';
import 'helpers/test_data.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(installTestHarness);
  tearDownAll(resetTestHarness);

  setUp(() async {
    await resetTestHarness();
  });

  patrolTest('photo caméra -> diagnostic -> journal', ($) async {
    addTearDown(resetTestHarness);

    // Étape 1 : préparer une session valide et une parcelle disponible.
    final imageFile = await createMockImageFile();
    final picker = TestImagePickerPlatform(imagePath: imageFile.path);
    await pumpApp(
      $,
      loggedIn: true,
      onboardingDone: true,
      isTfliteReady: true,
      tfliteResult: mockTfliteResult,
      imagePickerPlatform: picker,
    );
    await seedParcelles([buildTestParcelle(id: 1)]);

    // Étape 2 : vérifier l'écran d'accueil puis lancer le scan.
    expect(find.byType(HomeScreen), findsOneWidget);
    await $(find.bySemanticsLabel('Scanner une plante')).tap();
    await $.pumpAndSettle();

    // Étape 3 : vérifier l'écran de scan.
    expect(find.text('Scanner une feuille'), findsOneWidget);
    expect(find.textContaining('Pointez la camera vers'), findsOneWidget);

    // Étape 4 : lancer la capture puis choisir la parcelle.
    await $(find.byIcon(Icons.circle)).tap();
    await $.pumpAndSettle();
    await $('Parcelle Test').tap();
    await $.pumpAndSettle(const Duration(seconds: 10));

    // Étape 5 : vérifier le résultat.
    expect(find.byType(ScanResultScreen), findsOneWidget);
    expect(find.text('Brown spot'), findsWidgets);
    expect(find.textContaining('Modere'), findsWidgets);
    expect(find.textContaining('Améliorer la fertilisation'), findsWidgets);

    // Étape 6 : sauvegarder dans le journal.
    await $('Enregistrer').tap();
    await $.pumpAndSettle();

    // Étape 7 : vérifier la navigation vers le journal.
    expect(find.text('Journal agricole'), findsOneWidget);
    expect(find.text('Parcelle Test'), findsOneWidget);
    expect(find.textContaining('Brown spot'), findsWidgets);
  });

  patrolTest('cycle complet en mode avion', ($) async {
    addTearDown(resetTestHarness);

    // Étape 1 : préparer la session + un mock image picker.
    final imageFile = await createMockImageFile(fileName: 'scan-avion.jpg');
    final picker = TestImagePickerPlatform(imagePath: imageFile.path);
    final mockRemote = buildSuccessfulSyncRemoteDatasource();

    await pumpApp(
      $,
      loggedIn: true,
      onboardingDone: true,
      isTfliteReady: true,
      tfliteResult: mockTfliteResult,
      imagePickerPlatform: picker,
      additionalOverrides: <Override>[
        syncRemoteDatasourceProvider.overrideWithValue(mockRemote),
      ],
    );
    await seedParcelles([buildTestParcelle(id: 1)]);

    // Étape 2 : activer le mode avion.
    await $.platform.mobile.enableAirplaneMode();
    addTearDown(() async {
      await $.platform.mobile.disableAirplaneMode();
    });

    // Étape 3 : lancer un scan complet hors ligne.
    await $(find.bySemanticsLabel('Scanner une plante')).tap();
    await $.pumpAndSettle();
    await $(find.byIcon(Icons.circle)).tap();
    await $.pumpAndSettle();
    await $('Parcelle Test').tap();
    await $.pumpAndSettle(const Duration(seconds: 10));
    await $('Enregistrer').tap();
    await $.pumpAndSettle();

    // Étape 4 : vérifier l'indicateur hors ligne.
    expect(find.text('Mode hors ligne'), findsWidgets);

    // Étape 5 : revenir en ligne et déclencher la sync.
    await $.platform.mobile.disableAirplaneMode();
    await $.pumpAndSettle(const Duration(seconds: 5));

    final context = $.tester.element(find.byType(HomeScreen));
    final container = ProviderScope.containerOf(context, listen: false);
    await container.read(syncNotifierProvider.notifier).syncData();
    await $.pumpAndSettle();

    // Étape 6 : vérifier l'état de sync en succès.
    expect(find.byIcon(Icons.cloud_done_outlined), findsOneWidget);
  });

  patrolTest('IA non disponible (mode dégradé)', ($) async {
    addTearDown(resetTestHarness);

    // Étape 1 : démarrer l'app avec le moteur IA indisponible.
    await pumpApp(
      $,
      loggedIn: true,
      onboardingDone: true,
      isTfliteReady: false,
    );
    await seedParcelles([buildTestParcelle(id: 1)]);

    // Étape 2 : ouvrir l'écran de scan.
    await $(find.bySemanticsLabel('Scanner une plante')).tap();
    await $.pumpAndSettle();

    // Étape 3 : vérifier le message dégradé et l'absence de crash.
    expect(find.textContaining('Diagnostic IA indisponible'), findsWidgets);
    expect(find.text('L\'analyse se fait hors ligne'), findsWidgets);
  });

  patrolTest('partage du résultat sans exception', ($) async {
    addTearDown(resetTestHarness);

    // Étape 1 : produire un résultat de scan mocké.
    final imageFile = await createMockImageFile(fileName: 'scan-share.jpg');
    final picker = TestImagePickerPlatform(imagePath: imageFile.path);
    await pumpApp(
      $,
      loggedIn: true,
      onboardingDone: true,
      isTfliteReady: true,
      tfliteResult: mockTfliteResult,
      imagePickerPlatform: picker,
    );
    await seedParcelles([buildTestParcelle(id: 1)]);

    await $(find.bySemanticsLabel('Scanner une plante')).tap();
    await $.pumpAndSettle();
    await $(find.byIcon(Icons.circle)).tap();
    await $.pumpAndSettle();
    await $('Parcelle Test').tap();
    await $.pumpAndSettle(const Duration(seconds: 10));

    // Étape 2 : partager et vérifier qu'aucune exception n'est levée.
    await $('Partager le resultat').tap();
    await $.pumpAndSettle();
    expect(find.byType(ScanResultScreen), findsOneWidget);
  });

  patrolTest('permission caméra accordée', ($) async {
    addTearDown(resetTestHarness);

    // Étape 1 : lancer l'app en session valide.
    await pumpApp(
      $,
      loggedIn: true,
      onboardingDone: true,
      isTfliteReady: true,
    );

    // Étape 2 : ouvrir le scan et accorder la permission si dialog présent.
    await $(find.bySemanticsLabel('Scanner une plante')).tap();
    await $.pumpAndSettle();
    if (await $.platform.mobile.isPermissionDialogVisible()) {
      await $.platform.mobile.grantPermissionWhenInUse();
      await $.pumpAndSettle();
    }

    // Étape 3 : vérifier que la vue de scan reste accessible.
    expect(find.text('Scanner une feuille'), findsOneWidget);
    expect(find.textContaining('Pointez la camera vers'), findsOneWidget);
  });

  patrolTest('permission caméra refusée', ($) async {
    addTearDown(resetTestHarness);

    // Étape 1 : lancer l'app en session valide.
    await pumpApp(
      $,
      loggedIn: true,
      onboardingDone: true,
      isTfliteReady: true,
    );

    // Étape 2 : ouvrir le scan et refuser la permission si dialog présent.
    await $(find.bySemanticsLabel('Scanner une plante')).tap();
    await $.pumpAndSettle();
    if (await $.platform.mobile.isPermissionDialogVisible()) {
      await $.platform.mobile.denyPermission();
      await $.pumpAndSettle();
    }

    // Étape 3 : vérifier qu'il n'y a pas de crash.
    expect(find.text('Scanner une feuille'), findsOneWidget);
  });
}
