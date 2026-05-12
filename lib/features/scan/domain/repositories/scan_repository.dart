import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/scan_result_entity.dart';

enum ScanImageSource { camera, gallery }

abstract interface class ScanRepository {
  Future<Either<Failure, String>> captureImage({
    required ScanImageSource source,
  });

  Future<Either<Failure, ScanResultEntity>> analyzeImage({
    required String imagePath,
  });
}
