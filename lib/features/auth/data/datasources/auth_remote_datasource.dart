import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/auth_model.dart';

part 'auth_remote_datasource.g.dart';

@RestApi()
abstract class AuthRemoteDatasource {
  factory AuthRemoteDatasource(Dio dio, {String baseUrl}) =
      _AuthRemoteDatasource;

  @POST(ApiConstants.login)
  Future<AuthModel> login(@Body() Map<String, dynamic> body);
}
