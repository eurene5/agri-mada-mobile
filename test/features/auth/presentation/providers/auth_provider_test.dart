import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/errors/failure.dart';
import 'package:agri_mada/features/auth/domain/entities/auth_entity.dart';
import 'package:agri_mada/features/auth/domain/usecases/login_usecase.dart';
import 'package:agri_mada/features/auth/presentation/providers/auth_provider.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late ProviderContainer container;
  late MockLoginUseCase mockUseCase;

  const tEmail = 'user@agrimada.mg';
  const tPassword = 'password123';
  const tUser = AuthEntity(
    userId: 'user-001',
    email: tEmail,
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
  );

  setUp(() {
    mockUseCase = MockLoginUseCase();
    container = ProviderContainer(
      overrides: [loginUseCaseProvider.overrideWithValue(mockUseCase)],
    );
  });

  tearDown(() => container.dispose());

  group('AuthNotifier', () {
    test("l'état initial est AuthState.initial", () {
      expect(
        container.read(authNotifierProvider),
        const AuthState.initial(),
      );
    });

    test('passe par loading puis authenticated après login réussi', () async {
      // Arrange
      when(() => mockUseCase.call(email: tEmail, password: tPassword))
          .thenAnswer((_) async => const Right(tUser));

      final states = <AuthState>[];
      container.listen(authNotifierProvider, (_, s) => states.add(s));

      // Act
      await container
          .read(authNotifierProvider.notifier)
          .login(email: tEmail, password: tPassword);

      // Assert
      expect(states, [
        const AuthState.loading(),
        const AuthState.authenticated(tUser),
      ]);
    });

    test('passe en error() en cas de AuthFailure', () async {
      // Arrange
      when(() => mockUseCase.call(
              email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer(
              (_) async => const Left(AuthFailure('Identifiants incorrects')));

      // Act
      await container
          .read(authNotifierProvider.notifier)
          .login(email: tEmail, password: tPassword);

      // Assert
      expect(
        container.read(authNotifierProvider),
        const AuthState.error('Identifiants incorrects'),
      );
    });

    test('passe en error() avec message réseau en cas de NetworkFailure',
        () async {
      // Arrange
      when(() => mockUseCase.call(
              email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) async => const Left(NetworkFailure('No connection')));

      // Act
      await container
          .read(authNotifierProvider.notifier)
          .login(email: tEmail, password: tPassword);

      // Assert
      expect(
        container.read(authNotifierProvider),
        const AuthState.error('Pas de connexion internet'),
      );
    });

    test('logout remet l\'état à initial', () async {
      // Arrange
      when(() => mockUseCase.call(email: tEmail, password: tPassword))
          .thenAnswer((_) async => const Right(tUser));
      await container
          .read(authNotifierProvider.notifier)
          .login(email: tEmail, password: tPassword);

      // Act
      container.read(authNotifierProvider.notifier).logout();

      // Assert
      expect(
        container.read(authNotifierProvider),
        const AuthState.initial(),
      );
    });
  });
}
