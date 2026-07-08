part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;

  /// Proceed from the branded intro landing into the method chooser, choosing
  /// Sign up (Aanmelden) or Log in (Inloggen).
  const factory AuthEvent.introProceed(AuthMode mode) = _IntroProceed;

  /// Toggle between Log in and Sign up on the method-chooser step.
  const factory AuthEvent.modeChanged(AuthMode mode) = _ModeChanged;

  /// Pick Phone / Email / Google.
  const factory AuthEvent.methodSelected(AuthMethod method) = _MethodSelected;

  const factory AuthEvent.phoneSubmitted(String phone) = _PhoneSubmitted;
  const factory AuthEvent.emailSubmitted(String email) = _EmailSubmitted;
  const factory AuthEvent.otpSubmitted(String code) = _OtpSubmitted;
  const factory AuthEvent.resendRequested() = _ResendRequested;
  const factory AuthEvent.googleRequested() = _GoogleRequested;

  /// Finalize Google/email sign-up. [verifyNow] decides whether to route to the
  /// phone-verification screen afterwards.
  const factory AuthEvent.registrationSubmitted({
    required String name,
    required String phone,
    required bool verifyNow,
  }) = _RegistrationSubmitted;

  /// Go back one step (OTP/input/registration → previous).
  const factory AuthEvent.backRequested() = _BackRequested;

  /// Reset to the landing step.
  const factory AuthEvent.resetRequested() = _ResetRequested;

  const factory AuthEvent.tick() = _Tick;
}
