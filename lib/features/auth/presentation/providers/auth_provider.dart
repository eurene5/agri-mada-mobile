import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/local_db/session_service.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/login_usecase.dart';

part 'auth_provider.freezed.dart';
part 'auth_provider.g.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(AuthEntity user) = AuthAuthenticated;
  const factory AuthState.error(String message) = AuthError;
}

// ---------------------------------------------------------------------------
// Infrastructure providers
// ---------------------------------------------------------------------------

@riverpod
Dio dio(Ref ref) => ref.watch(dioClientProvider);

@riverpod
AuthRemoteDatasource authRemoteDatasource(Ref ref) =>
    AuthRemoteDatasource(ref.watch(dioProvider));

@riverpod
AuthRepositoryImpl authRepository(Ref ref) => AuthRepositoryImpl(
      ref.watch(authRemoteDatasourceProvider),
      sessionService: SessionService.instance,
    );

@riverpod
LoginUseCase loginUseCase(Ref ref) =>
    LoginUseCase(ref.watch(authRepositoryProvider));

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() => const AuthState.initial();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    final result = await ref.read(loginUseCaseProvider).call(
          email: email,
          password: password,
        );

    state = result.fold(
      (failure) => _mapFailureToState(failure),
      (user) => AuthState.authenticated(user),
    );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AuthState.initial();
  }

  AuthState _mapFailureToState(Failure failure) => switch (failure) {
        AuthFailure() => AuthState.error(failure.message),
        ValidationFailure() => AuthState.error(failure.message),
        NetworkFailure() => const AuthState.error('Pas de connexion internet'),
        _ => AuthState.error(failure.message),
      };
}
