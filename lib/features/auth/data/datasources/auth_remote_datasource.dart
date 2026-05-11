import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/auth_login_response_model.dart';
import '../params/auth_params.dart';

@lazySingleton
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthLoginResponseModel> login(LoginParams params) =>
      rethrowAsAppException(() async {
        final res = await _dio.post(
          ApiEndpoints.login,
          data: params.toJson(),
        );
        return AuthLoginResponseModel.fromJson(
          res.data as Map<String, dynamic>,
        );
      });
}
