import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:agri_mada/features/auth/presentation/screens/login_screen.dart';
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpLoginScreen(
    WidgetTester tester, {
    Locale locale = const Locale('fr'),
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: locale,
          supportedLocales: const [Locale('fr'), Locale('mg')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            _MgMaterialLocalizationsDelegate(),
            _MgCupertinoLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: LoginScreen(),
        ),
      ),

      testWidgets('locale mg ne leve pas d exception de delegates', (tester) async {
        // Arrange
        await pumpLoginScreen(tester, locale: const Locale('mg'));

        // Assert
        expect(find.byType(LoginScreen), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    );
    await tester.pumpAndSettle();
  }

  group('LoginScreen callbacks', () {
    testWidgets(
      'tap Mot de passe oublie affiche un dialog visible',
      (tester) async {
        // Arrange
        await pumpLoginScreen(tester);

        // Act
        await tester.tap(find.text('Mot de passe oublie ?'));
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Envoyer'), findsOneWidget);
      },
    );

    testWidgets(
      'tap S\'inscrire affiche une action visible (snackbar)',
      (tester) async {
        // Arrange
        await pumpLoginScreen(tester);

        // Act
        await tester.ensureVisible(find.text("S'inscrire"));
        await tester.tap(find.text("S'inscrire"));
        await tester.pump();

        // Assert
        expect(find.byType(SnackBar), findsOneWidget);
      },
    );

    testWidgets(
      'les callbacks Mot de passe oublie et S\'inscrire ne crashent pas',
      (tester) async {
        // Arrange
        await pumpLoginScreen(tester);

        // Act
        await tester.tap(find.text('Mot de passe oublie ?'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Annuler'));
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.text("S'inscrire"));
        await tester.tap(find.text("S'inscrire"));
        await tester.pumpAndSettle();

        // Assert
        expect(tester.takeException(), isNull);
      },
    );
  });
}
