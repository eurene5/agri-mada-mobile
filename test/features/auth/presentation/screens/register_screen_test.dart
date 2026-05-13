import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/app/router.dart';
import 'package:agri_mada/features/auth/domain/usecases/register_usecase.dart';
import 'package:agri_mada/features/auth/presentation/providers/auth_provider.dart';
import 'package:agri_mada/features/auth/presentation/screens/login_screen.dart';
import 'package:agri_mada/features/auth/presentation/screens/register_screen.dart';
import 'package:agri_mada/l10n/app_localizations.dart';

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RegisterScreen', () {
    testWidgets('affiche les champs d inscription', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: RegisterScreen()),
        ),
      );

      // Assert
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Prénom'), findsOneWidget);
      expect(find.text('Région'), findsOneWidget);
      expect(find.text('Téléphone'), findsOneWidget);
    });
  });
}
