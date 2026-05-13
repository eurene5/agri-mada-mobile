import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/errors/failure.dart';
import 'package:agri_mada/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:agri_mada/features/auth/domain/entities/auth_entity.dart';
import 'package:agri_mada/features/auth/domain/usecases/login_usecase.dart';
import 'package:agri_mada/features/auth/presentation/providers/auth_provider.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockAuthRepositoryImpl extends Mock implements AuthRepositoryImpl {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late MockLoginUseCase mockUseCase;
  late MockAuthRepositoryImpl mockAuthRepository;

  const tEmail = 'user@agrimada.mg';
  const tPassword = 'password123';
  const UserProfile tUser = UserProfile(
    userId: 'user-001',
    email: tEmail,
    phoneNumber: '0341234567',
  );

  setUp(() {
    mockUseCase = MockLoginUseCase();
    mockAuthRepository = MockAuthRepositoryImpl();

    when(() => mockAuthRepository.logout()).thenAnswer(
      (_) async => const Right(unit),
    );

    container = ProviderContainer(
      overrides: [
        loginUseCaseProvider.overrideWithValue(mockUseCase),
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
      ],
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
          .thenAnswer(
        (_) async => const Right<Failure, UserProfile>(tUser),
      );

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
          email: any(named: 'email'),
          password: any(named: 'password'))).thenAnswer(
        (_) async => const Left<Failure, UserProfile>(
          AuthFailure('Identifiants incorrects'),
        ),
      );

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
          email: any(named: 'email'),
          password: any(named: 'password'))).thenAnswer(
        (_) async => const Left<Failure, UserProfile>(
          NetworkFailure('No connection'),
        ),
      );

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
          .thenAnswer(
        (_) async => const Right<Failure, UserProfile>(tUser),
      );
      await container
          .read(authNotifierProvider.notifier)
          .login(email: tEmail, password: tPassword);

      // Act
      await container.read(authNotifierProvider.notifier).logout();

      // Assert
      expect(
        container.read(authNotifierProvider),
        const AuthState.initial(),
      );
    });
  });
}
