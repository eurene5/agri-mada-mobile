import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/scan_result_entity.dart';
import '../repositories/scan_repository.dart';

class AnalyzeImageUseCase {
  const AnalyzeImageUseCase(this._repository);

  final ScanRepository _repository;

  Future<Either<Failure, ScanResultEntity>> call({
    required String imagePath,
  }) {
    if (imagePath.isEmpty) {
      return Future.value(
        const Left(ValidationFailure('Aucune image à analyser')),
      );
    }
    return _repository.analyzeImage(imagePath: imagePath);
  }
}
