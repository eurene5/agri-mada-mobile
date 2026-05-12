import 'package:dio/dio.dart';

String? _extractServerMessage(Response<dynamic>? response) {
  final Object? data = response?.data;

  if (data case final Map<String, dynamic> map) {
    final Object? message = map['message'];
    return message is String ? message : null;
  }

  return null;
}

sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkException extends AppException {
  const NetworkException(super.message);

  factory NetworkException.fromDioError(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        const NetworkException('Délai de connexion dépassé'),
      DioExceptionType.connectionError =>
        const NetworkException('Impossible de se connecter au serveur'),
      DioExceptionType.badResponse => NetworkException(
          _extractServerMessage(e.response) ?? 'Erreur serveur',
        ),
      _ => NetworkException(e.message ?? 'Erreur réseau inconnue'),
    };
  }
}

final class ServerException extends AppException {
  const ServerException(super.message, {this.statusCode});
  final int? statusCode;
}

final class ParseException extends AppException {
  const ParseException(super.message);
}

final class AuthException extends AppException {
  const AuthException(super.message);
}
