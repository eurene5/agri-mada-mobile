import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/scan_result_entity.dart';
import '../../domain/repositories/scan_repository.dart';
import '../datasources/scan_local_datasource.dart';
import '../models/scan_result_model.dart';

class ScanRepositoryImpl implements ScanRepository {
  const ScanRepositoryImpl(this._local);

  final ScanLocalDatasource _local;

  @override
  Future<Either<Failure, String>> captureImage({
    required ScanImageSource source,
  }) async {
    try {
      final imagePath = await _local.captureImagePath(source: source);
      AppLogger.debug('Image capturée: $imagePath');
      return Right(imagePath);
    } on ScanCaptureCancelledException {
      return const Left(
          ValidationFailure('Capture annulée par l\'utilisateur'));
    } on ScanPermissionDeniedException {
      return const Left(
        ValidationFailure(
            'Permission caméra refusée. Activez-la dans les paramètres.'),
      );
    } catch (e, st) {
      AppLogger.error('Erreur capture image', error: e, stackTrace: st);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ScanResultEntity>> analyzeImage({
    required String imagePath,
  }) async {
    try {
      final model = await _local.analyzeImage(imagePath: imagePath);
      return Right(model.toEntity());
    } on ScanInvalidImageException catch (e) {
      return Left(ValidationFailure(e.message));
    } catch (e, st) {
      AppLogger.error('Erreur analyse image', error: e, stackTrace: st);
      return Left(UnknownFailure(e.toString()));
    }
  }
}
