import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../errors/failure.dart';
import '../local_db/session_service.dart';
import '../utils/logger.dart';

final apiBaseUrlProvider = Provider<String>((_) => ApiConstants.baseUrl);

final dioClientProvider = Provider<Dio>((ref) {
  final sessionService = SessionService.instance;
  final baseUrl = ref.watch(apiBaseUrlProvider);

  AppLogger.info('Dio baseUrl active: $baseUrl');

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await sessionService.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await sessionService.clearSession();
          handler.next(
            error.copyWith(
              error: const AuthFailure('Session expirée'),
            ),
          );
          return;
        }

        handler.next(error);
      },
    ),
  );

  return dio;
});
