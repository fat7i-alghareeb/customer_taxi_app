import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_login_response_model.dart';

part 'auth_otp_models.freezed.dart';
part 'auth_otp_models.g.dart';

/// Response of every request-OTP endpoint. Verification uses [otpRequestId] + code.
@freezed
abstract class OtpRequestResponseModel with _$OtpRequestResponseModel {
  const factory OtpRequestResponseModel({
    required String otpRequestId,
    required int expiresInSeconds,
    required int resendAvailableInSeconds,
  }) = _OtpRequestResponseModel;

  factory OtpRequestResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestResponseModelFromJson(json);
}

/// Verified email/Google identity that still needs a phone before the account exists.
@freezed
abstract class RegistrationChallengeModel with _$RegistrationChallengeModel {
  const factory RegistrationChallengeModel({
    required String registrationToken,
    String? email,
    String? name,
  }) = _RegistrationChallengeModel;

  factory RegistrationChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationChallengeModelFromJson(json);
}

/// Result of Google / email-signup verify: either a session or a registration challenge.
@freezed
abstract class AuthResultModel with _$AuthResultModel {
  const factory AuthResultModel({
    AuthLoginResponseModel? session,
    RegistrationChallengeModel? registration,
  }) = _AuthResultModel;

  factory AuthResultModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResultModelFromJson(json);
}
