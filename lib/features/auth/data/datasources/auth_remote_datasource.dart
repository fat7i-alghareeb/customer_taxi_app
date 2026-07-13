import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/auth_login_response_model.dart';
import '../models/auth_otp_models.dart';
import '../params/auth_params.dart';

@lazySingleton
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  // ---- Phone (backend-owned OTP via CM.com) ----

  Future<OtpRequestResponseModel> requestPhoneLoginOtp(PhoneOtpParams params) =>
      _requestOtp(ApiEndpoints.phoneLoginOtp, params.toJson());

  Future<AuthLoginResponseModel> verifyPhoneLoginOtp(VerifyOtpParams params) =>
      _verifySession(ApiEndpoints.phoneLoginOtpVerify, params.toJson());

  Future<OtpRequestResponseModel> requestPhoneSignupOtp(PhoneOtpParams params) =>
      _requestOtp(ApiEndpoints.phoneSignupOtp, params.toJson());

  Future<AuthLoginResponseModel> verifyPhoneSignupOtp(VerifyOtpParams params) =>
      _verifySession(ApiEndpoints.phoneSignupOtpVerify, params.toJson());

  // ---- Email (backend-owned OTP via Titan) ----

  Future<OtpRequestResponseModel> requestEmailLoginOtp(EmailOtpParams params) =>
      _requestOtp(ApiEndpoints.emailLoginOtp, params.toJson());

  Future<AuthLoginResponseModel> verifyEmailLoginOtp(VerifyOtpParams params) =>
      _verifySession(ApiEndpoints.emailLoginOtpVerify, params.toJson());

  Future<OtpRequestResponseModel> requestEmailSignupOtp(EmailOtpParams params) =>
      _requestOtp(ApiEndpoints.emailSignupOtp, params.toJson());

  Future<AuthResultModel> verifyEmailSignupOtp(VerifyOtpParams params) =>
      _verifyResult(ApiEndpoints.emailSignupOtpVerify, params.toJson());

  // ---- Google (Firebase token verified by backend) ----

  Future<AuthResultModel> googleAuth(GoogleAuthParams params) =>
      _verifyResult(ApiEndpoints.googleAuth, params.toJson());

  // ---- Registration finalize + phone verify + fresh start ----

  Future<AuthLoginResponseModel> completeRegistration(
    CompleteRegistrationParams params,
  ) =>
      _verifySession(ApiEndpoints.registerComplete, params.toJson());

  Future<OtpRequestResponseModel> requestPhoneVerifyOtp(PhoneOtpParams params) =>
      _requestOtp(ApiEndpoints.phoneVerifyOtp, params.toJson());

  Future<AuthLoginResponseModel> verifyPhoneVerifyOtp(VerifyOtpParams params) =>
      _verifySession(ApiEndpoints.phoneVerifyOtpVerify, params.toJson());

  Future<AuthLoginResponseModel> freshStart() =>
      rethrowAsAppException(() async {
        final res = await _dio.post(ApiEndpoints.accountFreshStart);
        return AuthLoginResponseModel.fromJson(res.data as Map<String, dynamic>);
      });

  Future<void> continueExistingAccount() => rethrowAsAppException(() async {
        await _dio.post(ApiEndpoints.accountContinueExisting);
      });

  // ---- Misc ----

  Future<void> updateFcmToken(String token) => rethrowAsAppException(() async {
        await _dio.put(ApiEndpoints.updateFcmToken, data: {'fcmToken': token});
      });

  Future<void> updatePreferredLanguage(String languageCode) =>
      rethrowAsAppException(() async {
        await _dio.put(
          ApiEndpoints.updatePreferredLanguage,
          data: {'languageCode': languageCode},
        );
      });

  // ---- shared helpers ----

  Future<OtpRequestResponseModel> _requestOtp(
    String path,
    Map<String, dynamic> data,
  ) =>
      rethrowAsAppException(() async {
        final res = await _dio.post(path, data: data);
        return OtpRequestResponseModel.fromJson(
          res.data as Map<String, dynamic>,
        );
      });

  Future<AuthLoginResponseModel> _verifySession(
    String path,
    Map<String, dynamic> data,
  ) =>
      rethrowAsAppException(() async {
        final res = await _dio.post(path, data: data);
        return AuthLoginResponseModel.fromJson(res.data as Map<String, dynamic>);
      });

  Future<AuthResultModel> _verifyResult(
    String path,
    Map<String, dynamic> data,
  ) =>
      rethrowAsAppException(() async {
        final res = await _dio.post(path, data: data);
        return AuthResultModel.fromJson(res.data as Map<String, dynamic>);
      });
}
