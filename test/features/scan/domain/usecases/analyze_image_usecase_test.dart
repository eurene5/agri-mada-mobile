import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/errors/failure.dart';
import 'package:agri_mada/features/scan/domain/entities/diagnostic_result.dart';
import 'package:agri_mada/features/scan/domain/repositories/scan_repository.dart';
import 'package:agri_mada/features/scan/domain/usecases/analyze_image_usecase.dart';

class MockScanRepository extends Mock implements ScanRepository {}

void main() {
  late MockScanRepository repository;
  late AnalyzeImageUseCase useCase;

  setUp(() {
    repository = MockScanRepository();
    useCase = AnalyzeImageUseCase(repository);
  });

  group('AnalyzeImageUseCase', () {
    test('retourne un DiagnosticResult quand l\'analyse reussit', () async {
      when(() => repository.analyze(any())).thenAnswer(
        (_) async => Right(
          DiagnosticResult(
            maladieDetectee: 'Brown spot',
            confiance: 0.93,
            createdAt: DateTime.now(),
            niveauGravite: 'modere',
            recommandations: ['Ameliorer la fertilisation'],
          ),
        ),
      );

      final result = await useCase('test.jpg');

      expect(result.isRight(), isTrue);
      verify(() => repository.analyze('test.jpg')).called(1);
    });

    test('retourne ValidationFailure pour chemin vide', () async {
      final result = await useCase('');

      expect(result, isA<Left<Failure, DiagnosticResult>>());
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected Left'),
      );
      verifyZeroInteractions(repository);
    });

    test('retourne Failure quand le repository echoue', () async {
      when(() => repository.analyze(any())).thenAnswer(
        (_) async => const Left(ServerFailure('Erreur TFLite')),
      );

      final result = await useCase('test.jpg');

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });
}
