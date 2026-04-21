import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/auth_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();
}
