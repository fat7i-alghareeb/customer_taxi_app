import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/services/session/auth_manager.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/auth_outcome.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/otp_request_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_firebase_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../mappers/auth_model_mapper.dart';
import '../models/auth_login_response_model.dart';
import '../models/auth_otp_models.dart';
import '../params/auth_params.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._firebase, this._remote, this._authManager);

  final AuthFirebaseDataSource _firebase;
  final AuthRemoteDataSource _remote;
  final AuthManager _authManager;

  // ---- Phone ----

  @override
  Future<Result<OtpRequestInfo>> requestPhoneLoginOtp(String phone) =>
      runAsResult(() async =>
          _toInfo(await _remote.requestPhoneLoginOtp(PhoneOtpParams(phone: phone))));

  @override
  Future<Result<AuthSession>> verifyPhoneLoginOtp({
    required String otpRequestId,
    required String code,
  }) =>
      runAsResult(() async {
        final fcm = await _firebase.getFcmToken();
        final res = await _remote.verifyPhoneLoginOtp(
          VerifyOtpParams(otpRequestId: otpRequestId, code: code, fcmToken: fcm),
        );
        return _persist(res);
      });

  @override
  Future<Result<OtpRequestInfo>> requestPhoneSignupOtp(String phone) =>
      runAsResult(() async => _toInfo(
          await _remote.requestPhoneSignupOtp(PhoneOtpParams(phone: phone))));

  @override
  Future<Result<AuthSession>> verifyPhoneSignupOtp({
    required String otpRequestId,
    required String code,
  }) =>
      runAsResult(() async {
        final fcm = await _firebase.getFcmToken();
        final res = await _remote.verifyPhoneSignupOtp(
          VerifyOtpParams(otpRequestId: otpRequestId, code: code, fcmToken: fcm),
        );
        return _persist(res);
      });

  // ---- Email ----

  @override
  Future<Result<OtpRequestInfo>> requestEmailLoginOtp(String email) =>
      runAsResult(() async => _toInfo(
          await _remote.requestEmailLoginOtp(EmailOtpParams(email: email))));

  @override
  Future<Result<AuthSession>> verifyEmailLoginOtp({
    required String otpRequestId,
    required String code,
  }) =>
      runAsResult(() async {
        final fcm = await _firebase.getFcmToken();
        final res = await _remote.verifyEmailLoginOtp(
          VerifyOtpParams(otpRequestId: otpRequestId, code: code, fcmToken: fcm),
        );
        return _persist(res);
      });

  @override
  Future<Result<OtpRequestInfo>> requestEmailSignupOtp(String email) =>
      runAsResult(() async => _toInfo(
          await _remote.requestEmailSignupOtp(EmailOtpParams(email: email))));

  @override
  Future<Result<AuthOutcome>> verifyEmailSignupOtp({
    required String otpRequestId,
    required String code,
  }) =>
      runAsResult(() async {
        final res = await _remote.verifyEmailSignupOtp(
          VerifyOtpParams(otpRequestId: otpRequestId, code: code),
        );
        return _toOutcome(res);
      });

  // ---- Google ----

  @override
  Future<Result<AuthOutcome>> signInWithGoogle() => runAsResult(() async {
        final idToken = await _firebase.signInWithGoogle();
        if (idToken == null) {
          printY('[GoogleAuth] repo: cancelled (no Firebase token)');
          return const CancelledOutcome();
        }
        final fcm = await _firebase.getFcmToken();
        printC('[GoogleAuth] repo: calling backend /auth/google');
        final res = await _remote.googleAuth(
          GoogleAuthParams(firebaseIdToken: idToken, fcmToken: fcm),
        );
        printG(
          '[GoogleAuth] repo: backend ok — '
          '${res.session != null ? 'existing session' : 'registration challenge'}',
        );
        return _toOutcome(res);
      });

  // ---- Registration finalize + phone verify + fresh start ----

  @override
  Future<Result<AuthSession>> completeRegistration({
    required String registrationToken,
    required String name,
    required String phone,
  }) =>
      runAsResult(() async {
        final fcm = await _firebase.getFcmToken();
        final res = await _remote.completeRegistration(
          CompleteRegistrationParams(
            registrationToken: registrationToken,
            name: name,
            phone: phone,
            fcmToken: fcm,
          ),
        );
        return _persist(res);
      });

  @override
  Future<Result<OtpRequestInfo>> requestPhoneVerifyOtp(String phone) =>
      runAsResult(() async => _toInfo(
          await _remote.requestPhoneVerifyOtp(PhoneOtpParams(phone: phone))));

  @override
  Future<Result<AuthSession>> verifyPhoneVerifyOtp({
    required String otpRequestId,
    required String code,
  }) =>
      runAsResult(() async {
        final res = await _remote.verifyPhoneVerifyOtp(
          VerifyOtpParams(otpRequestId: otpRequestId, code: code),
        );
        return _persist(res);
      });

  @override
  Future<Result<AuthSession>> freshStart() => runAsResult(() async {
        final res = await _remote.freshStart();
        return _persist(res);
      });

  @override
  Future<Result<void>> continueExistingAccount() =>
      runAsResult(() => _remote.continueExistingAccount());

  // ---- Misc ----

  @override
  Future<Result<void>> updateFcmToken(String token) =>
      runAsResult(() => _remote.updateFcmToken(token));

  @override
  Future<Result<void>> updatePreferredLanguage(String languageCode) =>
      runAsResult(() => _remote.updatePreferredLanguage(languageCode));

  // ---- helpers ----

  Future<AuthSession> _persist(AuthLoginResponseModel res) async {
    final user = res.toUserEntity();
    final token = res.toAuthTokenModel();
    await _authManager.login(user: user, token: token);
    return AuthSession(
      user: user,
      isNewAccount: res.isNewAccount,
      accountAlreadyExists: res.accountAlreadyExists,
    );
  }

  Future<AuthOutcome> _toOutcome(AuthResultModel res) async {
    if (res.session != null) {
      return SessionOutcome(await _persist(res.session!));
    }
    final reg = res.registration!;
    return RegistrationOutcome(
      registrationToken: reg.registrationToken,
      email: reg.email,
      name: reg.name,
    );
  }

  OtpRequestInfo _toInfo(OtpRequestResponseModel m) => OtpRequestInfo(
        otpRequestId: m.otpRequestId,
        expiresInSeconds: m.expiresInSeconds,
        resendAvailableInSeconds: m.resendAvailableInSeconds,
      );
}
