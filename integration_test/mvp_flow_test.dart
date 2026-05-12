import 'package:agri_mada/app/app.dart';
import 'package:agri_mada/app/router.dart';
import 'package:agri_mada/core/constants/test_keys.dart';
import 'package:agri_mada/features/home/presentation/screens/home_screen.dart';
import 'package:agri_mada/features/journal/presentation/screens/journal_screen.dart';
import 'package:agri_mada/features/scan/presentation/screens/scan_result_screen.dart';
import 'package:agri_mada/features/scan/presentation/screens/scanning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';

// Stratégie : surcharger routerProvider pour démarrer à /home.
// Élimine la dépendance au timer réel du splash (Future.delayed 2 s)
// qui bloque le binding live et provoque un timeout de 4 minutes.

GoRouter _buildTestRouter() => GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.scanning,
          builder: (context, state) => const ScanningScreen(),
        ),
        GoRoute(
          path: AppRoutes.scanResult,
          builder: (context, state) => const ScanResultScreen(),
        ),
        GoRoute(
          path: AppRoutes.journal,
          builder: (context, state) => const JournalScreen(),
        ),
      ],
    );

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Lance l'app avec le router de test (démarrage direct à /home).
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          routerProvider.overrideWithValue(_buildTestRouter()),
        ],
        child: const AgriMadaApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  /// Tape un widget et laisse la navigation se terminer (~300 ms).
  Future<void> tapAndSettle(
    WidgetTester tester,
    Finder finder,
  ) async {
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  group('MVP e2e flow', () {
    testWidgets(
      'parcours offline principal: home -> scan -> resultat -> journal',
      (tester) async {
        await pumpApp(tester);

        expect(find.byKey(const Key(TestKeys.homeScreen)), findsOneWidget);
        expect(
          find.byKey(const Key(TestKeys.homeOfflineBadge)),
          findsOneWidget,
        );

        await tapAndSettle(
          tester,
          find.byKey(const Key(TestKeys.homeScanFab)),
        );
        expect(find.byKey(const Key(TestKeys.scanningScreen)), findsOneWidget);

        await tapAndSettle(
          tester,
          find.byKey(const Key(TestKeys.scanningCaptureFab)),
        );
        expect(
          find.byKey(const Key(TestKeys.scanResultScreen)),
          findsOneWidget,
        );
        expect(find.text('Niveau de gravité'), findsOneWidget);
        expect(find.text('Recommandations adaptées'), findsOneWidget);

        await tapAndSettle(
          tester,
          find.byKey(const Key(TestKeys.scanResultSaveButton)),
        );
        expect(find.byKey(const Key(TestKeys.journalScreen)), findsOneWidget);
        expect(find.byKey(const Key(TestKeys.journalList)), findsOneWidget);
        expect(find.text('Journal agricole'), findsOneWidget);
      },
    );

    testWidgets(
      'rescan depuis resultat retourne sur ecran de scan',
      (tester) async {
        await pumpApp(tester);

        await tapAndSettle(
          tester,
          find.byKey(const Key(TestKeys.homeScanFab)),
        );
        await tapAndSettle(
          tester,
          find.byKey(const Key(TestKeys.scanningCaptureFab)),
        );
        expect(
          find.byKey(const Key(TestKeys.scanResultScreen)),
          findsOneWidget,
        );

        await tapAndSettle(
          tester,
          find.byKey(const Key(TestKeys.scanResultRescanButton)),
        );
        expect(find.byKey(const Key(TestKeys.scanningScreen)), findsOneWidget);
        expect(find.text('Scanner une feuille'), findsOneWidget);
      },
    );

    testWidgets(
      'navigation vers journal depuis la barre basse fonctionne',
      (tester) async {
        await pumpApp(tester);

        await tapAndSettle(
          tester,
          find.byKey(const Key(TestKeys.homeJournalNav)),
        );
        expect(find.byKey(const Key(TestKeys.journalScreen)), findsOneWidget);
        expect(find.text('Historique des analyses'), findsOneWidget);
      },
    );
  });
}
