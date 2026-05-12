import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/diagnostic_result.dart';

abstract interface class ScanRepository {
  Future<Either<Failure, DiagnosticResult>> analyze(String imagePath);

  Future<Either<Failure, Unit>> save(DiagnosticResult result);

  Future<Either<Failure, List<DiagnosticResult>>> getAll();
}
