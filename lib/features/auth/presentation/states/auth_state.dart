part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthMode.login) AuthMode mode,
    @Default(AuthStep.intro) AuthStep step,
    AuthMethod? method,
    OtpContext? otpContext,

    /// OTP request / Google / registration submit progress.
    @Default(BlocStatus<void>.initial()) BlocStatus<void> requestStatus,

    /// Final verify → authenticated session.
    @Default(BlocStatus<AuthSession>.initial()) BlocStatus<AuthSession> sessionStatus,
    String? otpRequestId,
    String? pendingPhone,
    String? pendingEmail,
    String? registrationToken,
    String? registrationEmail,
    String? registrationName,
    @Default(0) int resendSeconds,

    /// Set when a registration used "Verify now" so the screen routes to phone verify.
    @Default(false) bool routeToPhoneVerification,
  }) = _AuthState;
}
