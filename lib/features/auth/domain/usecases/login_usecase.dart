import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
  }) {
    if (email.isEmpty || password.isEmpty) {
      return Future.value(
        const Left(ValidationFailure('Email et mot de passe requis')),
      );
    }
    return _repository.login(email: email, password: password);
  }
}
