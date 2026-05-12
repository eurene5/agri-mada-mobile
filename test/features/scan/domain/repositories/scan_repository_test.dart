import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/errors/failure.dart';
import 'package:agri_mada/features/scan/domain/entities/diagnostic_result.dart';
import 'package:agri_mada/features/scan/domain/repositories/scan_repository.dart';

class MockScanRepository extends Mock implements ScanRepository {}

void main() {
  late MockScanRepository repository;

  const tResult = DiagnosticResult(
    id: 'diag-1',
    culture: 'Riz',
    maladieDetectee: 'Leaf smut',
    confiance: 0.88,
    imagePath: '/tmp/scan.jpg',
    createdAt: DateTime(2026, 5, 13),
    parcelleId: '1',
    niveauGravite: 'severe',
    recommandations: ['Traiter les semences'],
  );

  setUp(() {
    repository = MockScanRepository();
  });

  group('ScanRepository (contrat domain)', () {
    test('analyze() avec chemin valide retourne un DiagnosticResult', () async {
      // Arrange
      when(() => repository.analyze('/tmp/scan.jpg')).thenAnswer(
        (_) async => const Right(tResult),
      );

      // Act
      final result = await repository.analyze('/tmp/scan.jpg');

      // Assert
      expect(result, const Right(tResult));
      verify(() => repository.analyze('/tmp/scan.jpg')).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('analyze() avec chemin vide retourne une Failure de validation',
        () async {
      // Arrange
      when(() => repository.analyze('')).thenAnswer(
        (_) async => const Left(ValidationFailure('Chemin image invalide')),
      );

      // Act
      final result = await repository.analyze('');

      // Assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected a ValidationFailure'),
      );
      verify(() => repository.analyze('')).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('save() retourne Unit', () async {
      // Arrange
      when(() => repository.save(tResult)).thenAnswer(
        (_) async => const Right(unit),
      );

      // Act
      final result = await repository.save(tResult);

      // Assert
      expect(result, const Right(unit));
      verify(() => repository.save(tResult)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('getAll() retourne une liste de DiagnosticResult', () async {
      // Arrange
      when(() => repository.getAll()).thenAnswer(
        (_) async => const Right(<DiagnosticResult>[tResult]),
      );

      // Act
      final result = await repository.getAll();

      // Assert
      expect(result, const Right(<DiagnosticResult>[tResult]));
      verify(() => repository.getAll()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
