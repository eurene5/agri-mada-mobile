import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/errors/failure.dart';
import 'package:agri_mada/features/auth/domain/entities/auth_entity.dart';
import 'package:agri_mada/features/auth/domain/repositories/auth_repository.dart';
import 'package:agri_mada/features/auth/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepo;

  const tEmail = 'user@agrimada.mg';
  const tPassword = 'password123';
  const UserProfile tUser = UserProfile(
    userId: 'user-001',
    email: tEmail,
    phoneNumber: '0341234567',
  );

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = LoginUseCase(mockRepo);
  });

  group('LoginUseCase', () {
    test('retourne un AuthEntity quand le repository répond avec succès',
        () async {
      // Arrange
      when(() => mockRepo.login(email: tEmail, password: tPassword))
          .thenAnswer((_) async => const Right(tUser));

      // Act
      final result = await useCase(email: tEmail, password: tPassword);

      // Assert
      expect(result, const Right(tUser));
      verify(() => mockRepo.login(email: tEmail, password: tPassword))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('retourne un NetworkFailure quand le réseau est indisponible',
        () async {
      // Arrange
      when(() => mockRepo.login(
              email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) async => const Left(NetworkFailure('No connection')));

      // Act
      final result = await useCase(email: tEmail, password: tPassword);

      // Assert
      expect(result, const Left(NetworkFailure('No connection')));
    });

    test('retourne un AuthFailure quand les identifiants sont incorrects',
        () async {
      // Arrange
      when(() => mockRepo.login(
              email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer(
              (_) async => const Left(AuthFailure('Identifiants incorrects')));

      // Act
      final result = await useCase(email: tEmail, password: tPassword);

      // Assert
      result.fold(
        (f) => expect(f, isA<AuthFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('retourne une ValidationFailure sans appel réseau si email vide',
        () async {
      // Act
      final result = await useCase(email: '', password: tPassword);

      // Assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (f) => expect(f, isA<ValidationFailure>()),
        (_) => fail('Expected Left'),
      );
      verifyNever(
        () => mockRepo.login(
            email: any(named: 'email'), password: any(named: 'password')),
      );
    });

    test(
        'retourne une ValidationFailure sans appel réseau si mot de passe vide',
        () async {
      // Act
      final result = await useCase(email: tEmail, password: '');

      // Assert
      result.fold(
        (f) => expect(f, isA<ValidationFailure>()),
        (_) => fail('Expected Left'),
      );
      verifyNever(
        () => mockRepo.login(
            email: any(named: 'email'), password: any(named: 'password')),
      );
    });
  });
}
