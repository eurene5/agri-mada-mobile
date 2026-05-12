import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agri_mada/features/auth/presentation/screens/login_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpLoginScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
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
        await tester.tap(find.text('Mot de passe oublié?'));
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
        await tester.tap(find.text("S'inscrire"));
        await tester.pump();

        // Assert
        expect(find.text('Inscription bientôt disponible'), findsOneWidget);
      },
    );

    testWidgets(
      'les callbacks Mot de passe oublie et S\'inscrire ne crashent pas',
      (tester) async {
        // Arrange
        await pumpLoginScreen(tester);

        // Act
        await tester.tap(find.text('Mot de passe oublié?'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Annuler'));
        await tester.pumpAndSettle();

        await tester.tap(find.text("S'inscrire"));
        await tester.pumpAndSettle();

        // Assert
        expect(tester.takeException(), isNull);
      },
    );
  });
}
