import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_entity.freezed.dart';

@freezed
class AuthEntity with _$AuthEntity {
  const factory AuthEntity({
    required String userId,
    required String email,
    required String accessToken,
    required String refreshToken,
    String? displayName,
    String? avatarUrl,
  }) = _AuthEntity;
}
