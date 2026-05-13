import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agri_mada/features/auth/presentation/screens/reset_password_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ResetPasswordScreen', () {
    testWidgets('affiche le formulaire de telephone', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(home: ResetPasswordScreen()),
      );

      // Assert
      expect(find.text('Téléphone'), findsOneWidget);
      expect(find.text('Envoyer'), findsOneWidget);
    });

    testWidgets('affiche une confirmation quand on envoie le formulaire', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ResetPasswordScreen(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('fr')],
        ),
      );
      await tester.enterText(find.byType(TextFormField), '0341234567');

      // Act
      await tester.tap(find.text('Envoyer'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      // Assert
      expect(find.text('Fonctionnalite bientot disponible'), findsOneWidget);
    });
  });
}
