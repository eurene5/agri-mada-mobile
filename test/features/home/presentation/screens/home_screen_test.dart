import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:agri_mada/core/sync/providers/sync_provider.dart';
import 'package:agri_mada/features/auth/presentation/providers/session_provider.dart';
import 'package:agri_mada/features/home/presentation/screens/home_screen.dart';
import 'package:agri_mada/features/journal/presentation/providers/journal_provider.dart';

class _FakeSyncNotifier extends SyncNotifier {
  @override
  SyncState build() => const SyncState.idle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpHomeAtLanding(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/landing',
      routes: [
        GoRoute(
          path: '/landing',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Home Target')),
          ),
        ),
        GoRoute(
          path: '/scanning',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Scanning Target')),
          ),
        ),
        GoRoute(
          path: '/journal',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Journal Target')),
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          syncNotifierProvider.overrideWith(_FakeSyncNotifier.new),
          sessionProvider.overrideWith((ref) async {
            return {'prenom': 'Jean'};
          }),
          journalAgricoleProvider.overrideWith((ref) async {
            return <Map<String, dynamic>>[];
          }),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('HomeScreen callbacks', () {
    testWidgets(
      'callback menu ne crash pas et affiche une action visible (snackbar)',
      (tester) async {
        // Arrange
        await pumpHomeAtLanding(tester);

        // Act
        await tester.tap(find.bySemanticsLabel('Ouvrir le menu'));
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Bientôt disponible'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'callback Accueil ne crash pas et navigue vers /home',
      (tester) async {
        // Arrange
        await pumpHomeAtLanding(tester);

        // Act
        await tester.tap(find.bySemanticsLabel('Accueil'));
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Home Target'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  });
}
