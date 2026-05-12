import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/errors/failure.dart';
import 'package:agri_mada/features/scan/domain/entities/scan_result_entity.dart';
import 'package:agri_mada/features/scan/domain/repositories/scan_repository.dart';
import 'package:agri_mada/features/scan/domain/usecases/analyze_image_usecase.dart';

class MockScanRepository extends Mock implements ScanRepository {}

void main() {
  late AnalyzeImageUseCase useCase;
  late MockScanRepository mockRepository;

  const tPath = 'mock://captured-image.jpg';
  const tResult = ScanResultEntity(
    id: 'scan-1',
    imagePath: tPath,
    diseaseName: 'Riz Pyriculariose',
    scientificName: 'Magnaporthe oryzae',
    confidence: 0.89,
    severity: ScanSeverity.high,
    recommendations: [
      'Pulveriser un traitement biologique',
    ],
    tip: 'Eviter l arrosage tardif',
    analyzedAt: DateTime(2026, 1, 1),
  );

  setUp(() {
    mockRepository = MockScanRepository();
    useCase = AnalyzeImageUseCase(mockRepository);
  });

  group('AnalyzeImageUseCase', () {
    test('retourne ValidationFailure si le chemin image est vide', () async {
      // Act
      final result = await useCase.call(imagePath: '');

      // Assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, 'Aucune image a analyser');
        },
        (_) => fail('Expected Left'),
      );
      verifyNever(() =>
          mockRepository.analyzeImage(imagePath: any(named: 'imagePath')));
    });

    test('retourne ScanResultEntity quand le repository reussit', () async {
      // Arrange
      when(() => mockRepository.analyzeImage(imagePath: tPath))
          .thenAnswer((_) async => const Right(tResult));

      // Act
      final result = await useCase.call(imagePath: tPath);

      // Assert
      expect(result, const Right(tResult));
      verify(() => mockRepository.analyzeImage(imagePath: tPath)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('retourne Failure quand le repository echoue', () async {
      // Arrange
      when(() =>
              mockRepository.analyzeImage(imagePath: any(named: 'imagePath')))
          .thenAnswer((_) async => const Left(NetworkFailure('No connection')));

      // Act
      final result = await useCase.call(imagePath: tPath);

      // Assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });
}
