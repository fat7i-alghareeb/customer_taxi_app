import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/auth_login_response_model.dart';
import '../models/auth_session_token_model.dart';
import '../params/auth_params.dart';

@lazySingleton
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthSessionTokenModel> sendOtp(SendOtpParams params) =>
      rethrowAsAppException(() async {
        final res = await _dio.post(
          ApiEndpoints.sendOtp,
          data: params.toJson(),
        );
        return AuthSessionTokenModel.fromJson(
          res.data as Map<String, dynamic>,
        );
      });

  Future<AuthLoginResponseModel> verifyOtp(VerifyOtpParams params) =>
      rethrowAsAppException(() async {
        final res = await _dio.post(
          ApiEndpoints.verifyOtp,
          data: params.toJson(),
        );
        return AuthLoginResponseModel.fromJson(
          res.data as Map<String, dynamic>,
        );
      });
}
