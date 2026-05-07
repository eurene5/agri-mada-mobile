import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agri_mada/core/errors/failure.dart';
import 'package:agri_mada/features/scan/domain/entities/scan_result_entity.dart';
import 'package:agri_mada/features/scan/domain/usecases/analyze_image_usecase.dart';
import 'package:agri_mada/features/scan/domain/usecases/capture_image_usecase.dart';
import 'package:agri_mada/features/scan/domain/repositories/scan_repository.dart';
import 'package:agri_mada/features/scan/presentation/providers/scan_provider.dart';

class MockCaptureImageUseCase extends Mock implements CaptureImageUseCase {}

class MockAnalyzeImageUseCase extends Mock implements AnalyzeImageUseCase {}

void main() {
  late ProviderContainer container;
  late MockCaptureImageUseCase mockCaptureUseCase;
  late MockAnalyzeImageUseCase mockAnalyzeUseCase;

  const tImagePath = 'mock://captured-image.jpg';
  final tResult = ScanResultEntity(
    id: 'scan-123',
    imagePath: tImagePath,
    diseaseName: 'Riz Pyriculariose',
    scientificName: 'Magnaporthe oryzae',
    confidence: 0.91,
    severity: ScanSeverity.high,
    recommendations: ['Action 1'],
    tip: 'Action rapide',
    analyzedAt: DateTime(2026, 1, 1),
  );

  setUp(() {
    mockCaptureUseCase = MockCaptureImageUseCase();
    mockAnalyzeUseCase = MockAnalyzeImageUseCase();

    container = ProviderContainer(
      overrides: [
        captureImageUseCaseProvider.overrideWithValue(mockCaptureUseCase),
        analyzeImageUseCaseProvider.overrideWithValue(mockAnalyzeUseCase),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('ScanNotifier', () {
    test('l etat initial est ScanState.initial', () {
      expect(container.read(scanNotifierProvider), const ScanState.initial());
    });

    test('passe de capturing a success quand capture + analyse reussissent',
        () async {
      // Arrange
      when(() => mockCaptureUseCase.call(source: ScanImageSource.camera))
          .thenAnswer((_) async => const Right(tImagePath));
      when(() => mockAnalyzeUseCase.call(imagePath: tImagePath))
          .thenAnswer((_) async => Right(tResult));

      final states = <ScanState>[];
      container.listen(scanNotifierProvider, (_, next) => states.add(next));

      // Act
      await container.read(scanNotifierProvider.notifier).captureAndAnalyze();

      // Assert
      expect(states[0], const ScanState.capturing());
      expect(states[1], const ScanState.analyzing(tImagePath));
      expect(states[2], ScanState.success(tResult));
      verify(() => mockCaptureUseCase.call(source: ScanImageSource.camera))
          .called(1);
      verify(() => mockAnalyzeUseCase.call(imagePath: tImagePath)).called(1);
    });

    test('passe en error quand la capture echoue', () async {
      // Arrange
      when(() => mockCaptureUseCase.call(source: ScanImageSource.camera))
          .thenAnswer(
              (_) async => const Left(ValidationFailure('Capture annulee')));

      final states = <ScanState>[];
      container.listen(scanNotifierProvider, (_, next) => states.add(next));

      // Act
      await container.read(scanNotifierProvider.notifier).captureAndAnalyze();

      // Assert
      expect(states[0], const ScanState.capturing());
      expect(states[1], const ScanState.error('Capture annulee'));
      verify(() => mockCaptureUseCase.call(source: ScanImageSource.camera))
          .called(1);
      verifyNever(
          () => mockAnalyzeUseCase.call(imagePath: any(named: 'imagePath')));
    });
  });
}
