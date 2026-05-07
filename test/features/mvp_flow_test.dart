// Tests de navigation MVP — exécutés sur l'hôte (sans device physique).
// Ces tests couvrent les flux principaux sans IntegrationTestWidgetsFlutterBinding,
// ce qui les rend rapides et déterministes sur toutes les plateformes.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:agri_mada/app/router.dart';
import 'package:agri_mada/app/theme/app_theme.dart';
import 'package:agri_mada/core/constants/test_keys.dart';
import 'package:agri_mada/features/home/presentation/screens/home_screen.dart';
import 'package:agri_mada/features/journal/presentation/screens/journal_screen.dart';
import 'package:agri_mada/features/scan/presentation/screens/scan_result_screen.dart';
import 'package:agri_mada/features/scan/presentation/screens/scanning_screen.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

GoRouter _buildFullTestRouter() => GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (_, __) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.scanning,
          builder: (_, __) => const ScanningScreen(),
        ),
        GoRoute(
          path: AppRoutes.scanResult,
          builder: (_, __) => const ScanResultScreen(),
        ),
        GoRoute(
          path: AppRoutes.journal,
          builder: (_, __) => const JournalScreen(),
        ),
      ],
    );

Widget _buildTestApp(GoRouter router) => ProviderScope(
      child: MaterialApp.router(
        theme: AppTheme.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );

Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('MVP — écran d\'accueil', () {
    testWidgets('affiche le Scaffold home avec sa clé de test', (tester) async {
      // Arrange
      final router = _buildFullTestRouter();

      // Act
      await tester.pumpWidget(_buildTestApp(router));
      await _settle(tester);

      // Assert
      expect(find.byKey(const Key(TestKeys.homeScreen)), findsOneWidget);
    });

    testWidgets('affiche le badge mode hors-ligne', (tester) async {
      // Arrange
      final router = _buildFullTestRouter();

      // Act
      await tester.pumpWidget(_buildTestApp(router));
      await _settle(tester);

      // Assert
      expect(find.byKey(const Key(TestKeys.homeOfflineBadge)), findsOneWidget);
    });

    testWidgets('affiche le FAB de scan', (tester) async {
      // Arrange
      final router = _buildFullTestRouter();

      // Act
      await tester.pumpWidget(_buildTestApp(router));
      await _settle(tester);

      // Assert
      expect(find.byKey(const Key(TestKeys.homeScanFab)), findsOneWidget);
    });
  });

  group('MVP — navigation principale', () {
    testWidgets('parcours offline complet : home → scan → résultat → journal',
        (tester) async {
      // Arrange
      final router = _buildFullTestRouter();
      await tester.pumpWidget(_buildTestApp(router));
      await _settle(tester);

      // — home visible —
      expect(find.byKey(const Key(TestKeys.homeScreen)), findsOneWidget);

      // Act : tap FAB scan
      await tester.tap(find.byKey(const Key(TestKeys.homeScanFab)));
      await _settle(tester);

      // Assert : écran scan
      expect(find.byKey(const Key(TestKeys.scanningScreen)), findsOneWidget);

      // Act : capture
      await tester.tap(find.byKey(const Key(TestKeys.scanningCaptureFab)));
      await _settle(tester);
      await _settle(tester);

      // Assert : écran résultat
      expect(find.byKey(const Key(TestKeys.scanResultScreen)), findsOneWidget);

      // Act : enregistrer dans journal (scroll vers le bouton s'il est hors-viewport)
      await tester
          .ensureVisible(find.byKey(const Key(TestKeys.scanResultSaveButton)));
      await _settle(tester);
      final saveButton = tester.widget<ElevatedButton>(
        find.byKey(const Key(TestKeys.scanResultSaveButton)),
      );
      expect(saveButton.onPressed, isNotNull);
      saveButton.onPressed!.call();
      await _settle(tester);
      await tester.pump(const Duration(milliseconds: 800));
      await tester.pump(const Duration(milliseconds: 800));

      // Assert : journal
      expect(find.byKey(const Key(TestKeys.journalScreen)), findsOneWidget);
    });

    testWidgets('navigation vers journal depuis la barre du bas fonctionne',
        (tester) async {
      // Arrange
      final router = _buildFullTestRouter();
      await tester.pumpWidget(_buildTestApp(router));
      await _settle(tester);

      // Act
      await tester.tap(find.byKey(const Key(TestKeys.homeJournalNav)));
      await _settle(tester);

      // Assert
      expect(find.byKey(const Key(TestKeys.journalScreen)), findsOneWidget);
    });
  });

  group('MVP — flux scan', () {
    testWidgets('rescan depuis résultat retourne sur l\'écran de scan',
        (tester) async {
      // Arrange — démarrer directement sur scan-result
      final router = GoRouter(
        initialLocation: AppRoutes.scanResult,
        routes: [
          GoRoute(
            path: AppRoutes.scanning,
            builder: (_, __) => const ScanningScreen(),
          ),
          GoRoute(
            path: AppRoutes.scanResult,
            builder: (_, __) => const ScanResultScreen(),
          ),
        ],
      );
      await tester.pumpWidget(_buildTestApp(router));
      await _settle(tester);
      expect(find.byKey(const Key(TestKeys.scanResultScreen)), findsOneWidget);

      // Act
      await tester.ensureVisible(
          find.byKey(const Key(TestKeys.scanResultRescanButton)));
      await _settle(tester);
      await tester.tap(find.byKey(const Key(TestKeys.scanResultRescanButton)));
      await _settle(tester);

      // Assert
      expect(find.byKey(const Key(TestKeys.scanningScreen)), findsOneWidget);
    });

    testWidgets('le FAB de capture est visible sur l\'écran de scan',
        (tester) async {
      // Arrange
      final router = GoRouter(
        initialLocation: AppRoutes.scanning,
        routes: [
          GoRoute(
            path: AppRoutes.scanning,
            builder: (_, __) => const ScanningScreen(),
          ),
          GoRoute(
            path: AppRoutes.scanResult,
            builder: (_, __) => const ScanResultScreen(),
          ),
        ],
      );

      // Act
      await tester.pumpWidget(_buildTestApp(router));
      await _settle(tester);

      // Assert
      expect(find.byKey(const Key(TestKeys.scanningScreen)), findsOneWidget);
      expect(
          find.byKey(const Key(TestKeys.scanningCaptureFab)), findsOneWidget);
    });

    testWidgets(
        'les boutons rescan et enregistrer sont visibles sur l\'écran résultat',
        (tester) async {
      // Arrange
      final router = GoRouter(
        initialLocation: AppRoutes.scanning,
        routes: [
          GoRoute(
            path: AppRoutes.scanResult,
            builder: (_, __) => const ScanResultScreen(),
          ),
          GoRoute(
            path: AppRoutes.scanning,
            builder: (_, __) => const ScanningScreen(),
          ),
          GoRoute(
            path: AppRoutes.journal,
            builder: (_, __) => const JournalScreen(),
          ),
        ],
      );

      // Act
      await tester.pumpWidget(_buildTestApp(router));
      await _settle(tester);
      await tester.tap(find.byKey(const Key(TestKeys.scanningCaptureFab)));
      await _settle(tester);
      await _settle(tester);

      expect(find.byKey(const Key(TestKeys.scanResultScreen)), findsOneWidget);

      // Assert — les widgets existent dans l'arbre même hors-viewport
      expect(find.byKey(const Key(TestKeys.scanResultRescanButton)),
          findsOneWidget);
      expect(
          find.byKey(const Key(TestKeys.scanResultSaveButton)), findsOneWidget);
    });
  });

  group('MVP — écran journal', () {
    testWidgets('l\'écran journal s\'affiche avec sa clé', (tester) async {
      // Arrange
      final router = GoRouter(
        initialLocation: AppRoutes.journal,
        routes: [
          GoRoute(
            path: AppRoutes.journal,
            builder: (_, __) => const JournalScreen(),
          ),
        ],
      );

      // Act
      await tester.pumpWidget(_buildTestApp(router));
      await _settle(tester);

      // Assert
      expect(find.byKey(const Key(TestKeys.journalScreen)), findsOneWidget);
    });
  });
}
