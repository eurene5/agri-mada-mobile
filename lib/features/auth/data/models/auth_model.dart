import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_entity.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AuthModel({
    required String userId,
    required String email,
    required String accessToken,
    required String refreshToken,
    String? displayName,
    String? avatarUrl,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}

extension AuthModelMapper on AuthModel {
  AuthEntity toEntity() => AuthEntity(
        userId: userId,
        email: email,
        accessToken: accessToken,
        refreshToken: refreshToken,
        displayName: displayName,
        avatarUrl: avatarUrl,
      );
}
