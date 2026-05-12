import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/diagnostic_result.dart';
import '../repositories/scan_repository.dart';

class AnalyzeImageUseCase {
  const AnalyzeImageUseCase(this._repository);

  final ScanRepository _repository;

  Future<Either<Failure, DiagnosticResult>> call(String imagePath) {
    if (imagePath.trim().isEmpty) {
      return Future.value(
        const Left(ValidationFailure('Chemin image requis')),
      );
    }

    return _repository.analyze(imagePath);
  }
}
