import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/scan_repository.dart';

class CaptureImageUseCase {
  const CaptureImageUseCase(this._repository);

  final ScanRepository _repository;

  Future<Either<Failure, String>> call({
    required ScanImageSource source,
  }) {
    return _repository.captureImage(source: source);
  }
}
