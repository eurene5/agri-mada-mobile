import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/auth_model.dart';

part 'auth_remote_datasource.g.dart';

@RestApi()
abstract class AuthRemoteDatasource {
  factory AuthRemoteDatasource(Dio dio, {String baseUrl}) =
      _AuthRemoteDatasource;

  @FormUrlEncoded()
  @POST(ApiConstants.login)
  Future<AuthModel> login(
    @Field('username') String username,
    @Field('password') String password,
  );

  @GET(ApiConstants.me)
  Future<Map<String, Object?>> getMe(
    @Header('Authorization') String authorization,
  );
}
