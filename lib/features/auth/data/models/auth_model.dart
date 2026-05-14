import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/auth_entity.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AuthModel({
    required String accessToken,
    required String tokenType,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}

extension AuthModelMapper on AuthModel {
  AuthToken toEntity() => AuthToken(
        accessToken: accessToken,
        tokenType: tokenType,
      );
}
