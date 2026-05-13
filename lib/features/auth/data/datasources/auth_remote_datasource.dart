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
  @POST(ApiConstants.register)
  Future<Map<String, dynamic>> register(
    @Field('nom') String nom,
    @Field('prenom') String prenom,
    @Field('region') String region,
    @Field('tel') String tel,
    @Field('password') String password,
  );

  @FormUrlEncoded()
  @POST(ApiConstants.login)
  Future<AuthModel> login(
    @Field('username') String username,
    @Field('password') String password,
  );

  @GET(ApiConstants.me)
  Future<Map<String, dynamic>> getMe(
    @Header('Authorization') String authorization,
  );
}
