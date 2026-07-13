import '../../../../core/utils/result.dart';
import '../entities/auth_outcome.dart';
import '../entities/auth_session.dart';
import '../entities/otp_request_info.dart';

/// All OTP generation/verification and account logic lives on the backend; this
/// repository is a thin, state-driven client over those endpoints. Session-producing
/// methods persist the session via AuthManager before returning.
abstract class AuthRepository {
  // Phone
  Future<Result<OtpRequestInfo>> requestPhoneLoginOtp(String phone);
  Future<Result<AuthSession>> verifyPhoneLoginOtp({
    required String otpRequestId,
    required String code,
  });
  Future<Result<OtpRequestInfo>> requestPhoneSignupOtp(String phone);
  Future<Result<AuthSession>> verifyPhoneSignupOtp({
    required String otpRequestId,
    required String code,
  });

  // Email
  Future<Result<OtpRequestInfo>> requestEmailLoginOtp(String email);
  Future<Result<AuthSession>> verifyEmailLoginOtp({
    required String otpRequestId,
    required String code,
  });
  Future<Result<OtpRequestInfo>> requestEmailSignupOtp(String email);
  Future<Result<AuthOutcome>> verifyEmailSignupOtp({
    required String otpRequestId,
    required String code,
  });

  // Google
  Future<Result<AuthOutcome>> signInWithGoogle();

  // Registration finalize + phone verify + fresh start
  Future<Result<AuthSession>> completeRegistration({
    required String registrationToken,
    required String name,
    required String phone,
  });
  Future<Result<OtpRequestInfo>> requestPhoneVerifyOtp(String phone);
  Future<Result<AuthSession>> verifyPhoneVerifyOtp({
    required String otpRequestId,
    required String code,
  });
  Future<Result<AuthSession>> freshStart();
  Future<Result<void>> continueExistingAccount();

  // Misc
  Future<Result<void>> updateFcmToken(String token);
  Future<Result<void>> updatePreferredLanguage(String languageCode);
}
