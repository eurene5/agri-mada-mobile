import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote);

  final AuthRemoteDatasource _remote;

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _remote.login({'email': email, 'password': password});
      AppLogger.debug('Login réussi: ${model.userId}');
      return Right(model.toEntity());
    } on DioException catch (e, st) {
      final exception = NetworkException.fromDioError(e);
      AppLogger.error('Login échoué', error: exception, stackTrace: st);
      if (e.response?.statusCode == 401) {
        return const Left(AuthFailure('Identifiants incorrects'));
      }
      return Left(NetworkFailure(exception.message));
    } on ParseException catch (e, st) {
      AppLogger.error('Erreur de parsing', error: e, stackTrace: st);
      return Left(ServerFailure(e.message));
    } catch (e, st) {
      AppLogger.error('Erreur inconnue', error: e, stackTrace: st);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    return const Right(unit);
  }
}
