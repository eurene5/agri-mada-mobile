import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:agri_mada/core/sync/providers/sync_provider.dart';
import 'package:agri_mada/features/auth/presentation/providers/session_provider.dart';
import 'package:agri_mada/features/home/presentation/screens/home_screen.dart';
import 'package:agri_mada/features/journal/presentation/providers/journal_provider.dart';
import 'package:agri_mada/l10n/app_localizations.dart';

class _MgMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _MgMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mg';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('fr'));

  @override
  bool shouldReload(_MgMaterialLocalizationsDelegate old) => false;
}

class _MgCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _MgCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mg';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('fr'));

  @override
  bool shouldReload(_MgCupertinoLocalizationsDelegate old) => false;
}

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
        child: MaterialApp.router(
          routerConfig: router,
          locale: const Locale('fr'),
          supportedLocales: const [Locale('fr'), Locale('mg')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            _MgMaterialLocalizationsDelegate(),
            _MgCupertinoLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
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
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(SnackBar), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'callback Accueil ne crash pas et navigue vers /home',
      (tester) async {
        // Arrange
        await pumpHomeAtLanding(tester);

        // Act
        await tester.tap(find.byIcon(Icons.home_outlined));
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Home Target'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  });
}
