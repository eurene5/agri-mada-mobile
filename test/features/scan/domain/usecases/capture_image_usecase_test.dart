import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/errors/failure.dart';
import 'package:agri_mada/features/scan/domain/repositories/scan_repository.dart';
import 'package:agri_mada/features/scan/domain/usecases/capture_image_usecase.dart';

class MockScanRepository extends Mock implements ScanRepository {}

void main() {
  late CaptureImageUseCase useCase;
  late MockScanRepository mockRepository;

  setUp(() {
    mockRepository = MockScanRepository();
    useCase = CaptureImageUseCase(mockRepository);
  });

  group('CaptureImageUseCase', () {
    test('retourne un chemin image quand le repository reussit', () async {
      // Arrange
      when(() => mockRepository.captureImage(source: ScanImageSource.camera))
          .thenAnswer((_) async => const Right('mock://captured-image.jpg'));

      // Act
      final result = await useCase.call(source: ScanImageSource.camera);

      // Assert
      expect(result, const Right('mock://captured-image.jpg'));
      verify(() => mockRepository.captureImage(source: ScanImageSource.camera))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('retourne ValidationFailure quand la capture echoue', () async {
      // Arrange
      when(() => mockRepository.captureImage(source: ScanImageSource.gallery))
          .thenAnswer(
              (_) async => const Left(ValidationFailure('Capture annulee')));

      // Act
      final result = await useCase.call(source: ScanImageSource.gallery);

      // Assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });
}
