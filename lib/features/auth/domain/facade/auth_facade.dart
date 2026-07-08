import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/auth_outcome.dart';
import '../entities/auth_session.dart';
import '../entities/otp_request_info.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class AuthFacade {
  const AuthFacade(this._repository);

  final AuthRepository _repository;

  Future<Result<OtpRequestInfo>> requestPhoneLoginOtp(String phone) =>
      _repository.requestPhoneLoginOtp(phone);

  Future<Result<AuthSession>> verifyPhoneLoginOtp({
    required String otpRequestId,
    required String code,
  }) =>
      _repository.verifyPhoneLoginOtp(otpRequestId: otpRequestId, code: code);

  Future<Result<OtpRequestInfo>> requestPhoneSignupOtp(String phone) =>
      _repository.requestPhoneSignupOtp(phone);

  Future<Result<AuthSession>> verifyPhoneSignupOtp({
    required String otpRequestId,
    required String code,
  }) =>
      _repository.verifyPhoneSignupOtp(otpRequestId: otpRequestId, code: code);

  Future<Result<OtpRequestInfo>> requestEmailLoginOtp(String email) =>
      _repository.requestEmailLoginOtp(email);

  Future<Result<AuthSession>> verifyEmailLoginOtp({
    required String otpRequestId,
    required String code,
  }) =>
      _repository.verifyEmailLoginOtp(otpRequestId: otpRequestId, code: code);

  Future<Result<OtpRequestInfo>> requestEmailSignupOtp(String email) =>
      _repository.requestEmailSignupOtp(email);

  Future<Result<AuthOutcome>> verifyEmailSignupOtp({
    required String otpRequestId,
    required String code,
  }) =>
      _repository.verifyEmailSignupOtp(otpRequestId: otpRequestId, code: code);

  Future<Result<AuthOutcome>> signInWithGoogle() =>
      _repository.signInWithGoogle();

  Future<Result<AuthSession>> completeRegistration({
    required String registrationToken,
    required String name,
    required String phone,
  }) =>
      _repository.completeRegistration(
        registrationToken: registrationToken,
        name: name,
        phone: phone,
      );

  Future<Result<OtpRequestInfo>> requestPhoneVerifyOtp(String phone) =>
      _repository.requestPhoneVerifyOtp(phone);

  Future<Result<AuthSession>> verifyPhoneVerifyOtp({
    required String otpRequestId,
    required String code,
  }) =>
      _repository.verifyPhoneVerifyOtp(otpRequestId: otpRequestId, code: code);

  Future<Result<AuthSession>> freshStart() => _repository.freshStart();
}
