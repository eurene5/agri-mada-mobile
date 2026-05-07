import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../data/datasources/scan_local_datasource.dart';
import '../../data/repositories/scan_repository_impl.dart';
import '../../domain/entities/scan_result_entity.dart';
import '../../domain/repositories/scan_repository.dart';
import '../../domain/usecases/analyze_image_usecase.dart';
import '../../domain/usecases/capture_image_usecase.dart';

part 'scan_provider.freezed.dart';
part 'scan_provider.g.dart';

@freezed
class ScanState with _$ScanState {
  const factory ScanState.initial() = ScanInitial;
  const factory ScanState.capturing() = ScanCapturing;
  const factory ScanState.analyzing(String imagePath) = ScanAnalyzing;
  const factory ScanState.success(ScanResultEntity result) = ScanSuccess;
  const factory ScanState.error(String message) = ScanError;
}

@riverpod
ImagePicker imagePicker(Ref ref) => ImagePicker();

@riverpod
ScanLocalDatasource scanLocalDatasource(Ref ref) =>
    ScanLocalDatasource(ref.watch(imagePickerProvider));

@riverpod
ScanRepository scanRepository(Ref ref) =>
    ScanRepositoryImpl(ref.watch(scanLocalDatasourceProvider));

@riverpod
CaptureImageUseCase captureImageUseCase(Ref ref) =>
    CaptureImageUseCase(ref.watch(scanRepositoryProvider));

@riverpod
AnalyzeImageUseCase analyzeImageUseCase(Ref ref) =>
    AnalyzeImageUseCase(ref.watch(scanRepositoryProvider));

@riverpod
class ScanNotifier extends _$ScanNotifier {
  @override
  ScanState build() => const ScanState.initial();

  Future<void> captureAndAnalyze({
    ScanImageSource source = ScanImageSource.camera,
  }) async {
    state = const ScanState.capturing();

    final capture = await ref.read(captureImageUseCaseProvider).call(
          source: source,
        );

    final imagePath = capture.fold<String?>(
      (failure) {
        state = ScanState.error(_toMessage(failure));
        return null;
      },
      (path) => path,
    );

    if (imagePath == null) return;

    state = ScanState.analyzing(imagePath);

    final analysis = await ref.read(analyzeImageUseCaseProvider).call(
          imagePath: imagePath,
        );

    state = analysis.fold(
      (failure) => ScanState.error(_toMessage(failure)),
      (result) => ScanState.success(result),
    );
  }

  void clear() {
    state = const ScanState.initial();
  }

  String _toMessage(Failure failure) => failure.message;
}
