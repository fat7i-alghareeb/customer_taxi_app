import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/bloc_status.dart';
import '../../constants/auth_strings.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/auth_outcome.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/otp_request_info.dart';
import '../../domain/facade/auth_facade.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

enum AuthMode { login, signup }

enum AuthMethod { phone, email, google }

enum AuthStep { intro, landing, phoneInput, emailInput, otp, registration }

/// Which verify endpoint an entered OTP maps to.
enum OtpContext { phoneLogin, phoneSignup, emailLogin, emailSignup }

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._facade) : super(const AuthState()) {
    on<_Started>(_onStarted);
    on<_IntroProceed>(_onIntroProceed);
    on<_ModeChanged>(_onModeChanged);
    on<_MethodSelected>(_onMethodSelected);
    on<_PhoneSubmitted>(_onPhoneSubmitted);
    on<_EmailSubmitted>(_onEmailSubmitted);
    on<_OtpSubmitted>(_onOtpSubmitted);
    on<_ResendRequested>(_onResendRequested);
    on<_GoogleRequested>(_onGoogleRequested);
    on<_RegistrationSubmitted>(_onRegistrationSubmitted);
    on<_BackRequested>(_onBackRequested);
    on<_ResetRequested>(_onResetRequested);
    on<_Tick>(_onTick);
  }

  final AuthFacade _facade;
  Timer? _resendTimer;

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }

  void _onStarted(_Started event, Emitter<AuthState> emit) {
    _resendTimer?.cancel();
    emit(const AuthState());
  }

  void _onIntroProceed(_IntroProceed event, Emitter<AuthState> emit) {
    emit(state.copyWith(mode: event.mode, step: AuthStep.landing));
  }

  void _onModeChanged(_ModeChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(mode: event.mode));
  }

  Future<void> _onMethodSelected(
    _MethodSelected event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.method) {
      case AuthMethod.phone:
        emit(state.copyWith(method: AuthMethod.phone, step: AuthStep.phoneInput));
      case AuthMethod.email:
        emit(state.copyWith(method: AuthMethod.email, step: AuthStep.emailInput));
      case AuthMethod.google:
        add(const AuthEvent.googleRequested());
    }
  }

  Future<void> _onPhoneSubmitted(
    _PhoneSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.requestStatus.isLoading) return;
    emit(state.copyWith(requestStatus: const BlocStatus.loading()));

    final isLogin = state.mode == AuthMode.login;
    final result = isLogin
        ? await _facade.requestPhoneLoginOtp(event.phone)
        : await _facade.requestPhoneSignupOtp(event.phone);

    result.when(
      success: (info) => _onOtpIssued(
        emit,
        info: info,
        pendingPhone: event.phone,
        context: isLogin ? OtpContext.phoneLogin : OtpContext.phoneSignup,
      ),
      failure: (message) =>
          emit(state.copyWith(requestStatus: BlocStatus.failure(message))),
    );
  }

  Future<void> _onEmailSubmitted(
    _EmailSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.requestStatus.isLoading) return;
    emit(state.copyWith(requestStatus: const BlocStatus.loading()));

    final isLogin = state.mode == AuthMode.login;
    final result = isLogin
        ? await _facade.requestEmailLoginOtp(event.email)
        : await _facade.requestEmailSignupOtp(event.email);

    result.when(
      success: (info) => _onOtpIssued(
        emit,
        info: info,
        pendingEmail: event.email,
        context: isLogin ? OtpContext.emailLogin : OtpContext.emailSignup,
      ),
      failure: (message) =>
          emit(state.copyWith(requestStatus: BlocStatus.failure(message))),
    );
  }

  void _onOtpIssued(
    Emitter<AuthState> emit, {
    required OtpRequestInfo info,
    required OtpContext context,
    String? pendingPhone,
    String? pendingEmail,
  }) {
    emit(state.copyWith(
      requestStatus: const BlocStatus.success(null),
      step: AuthStep.otp,
      otpContext: context,
      otpRequestId: info.otpRequestId,
      pendingPhone: pendingPhone ?? state.pendingPhone,
      pendingEmail: pendingEmail ?? state.pendingEmail,
      sessionStatus: const BlocStatus.initial(),
    ));
    _startResendCountdown(emit, info.resendAvailableInSeconds);
  }

  Future<void> _onOtpSubmitted(
    _OtpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final requestId = state.otpRequestId;
    final context = state.otpContext;
    if (requestId == null || context == null) return;
    if (state.sessionStatus.isLoading) return;

    emit(state.copyWith(sessionStatus: const BlocStatus.loading()));

    switch (context) {
      case OtpContext.phoneLogin:
        _emitSession(emit,
            await _facade.verifyPhoneLoginOtp(otpRequestId: requestId, code: event.code));
      case OtpContext.phoneSignup:
        _emitSession(emit,
            await _facade.verifyPhoneSignupOtp(otpRequestId: requestId, code: event.code));
      case OtpContext.emailLogin:
        _emitSession(emit,
            await _facade.verifyEmailLoginOtp(otpRequestId: requestId, code: event.code));
      case OtpContext.emailSignup:
        final result =
            await _facade.verifyEmailSignupOtp(otpRequestId: requestId, code: event.code);
        result.when(
          success: (outcome) => _handleOutcome(emit, outcome),
          failure: (message) =>
              emit(state.copyWith(sessionStatus: BlocStatus.failure(message))),
        );
    }
  }

  Future<void> _onResendRequested(
    _ResendRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.resendSeconds > 0) return;
    final context = state.otpContext;
    if (context == null) return;

    Result<OtpRequestInfo> result;
    switch (context) {
      case OtpContext.phoneLogin:
        result = await _facade.requestPhoneLoginOtp(state.pendingPhone ?? '');
      case OtpContext.phoneSignup:
        result = await _facade.requestPhoneSignupOtp(state.pendingPhone ?? '');
      case OtpContext.emailLogin:
        result = await _facade.requestEmailLoginOtp(state.pendingEmail ?? '');
      case OtpContext.emailSignup:
        result = await _facade.requestEmailSignupOtp(state.pendingEmail ?? '');
    }

    result.when(
      success: (info) {
        emit(state.copyWith(otpRequestId: info.otpRequestId));
        _startResendCountdown(emit, info.resendAvailableInSeconds);
      },
      failure: (message) =>
          emit(state.copyWith(sessionStatus: BlocStatus.failure(message))),
    );
  }

  Future<void> _onGoogleRequested(
    _GoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.requestStatus.isLoading) return;
    emit(state.copyWith(
      method: AuthMethod.google,
      requestStatus: const BlocStatus.loading(),
    ));

    final result = await _facade.signInWithGoogle();
    result.when(
      success: (outcome) {
        emit(state.copyWith(requestStatus: const BlocStatus.success(null)));
        _handleOutcome(emit, outcome);
      },
      failure: (message) {
        printR('[GoogleAuth] bloc: sign-in failed → "$message"');
        emit(state.copyWith(requestStatus: BlocStatus.failure(message)));
      },
    );
  }

  Future<void> _onRegistrationSubmitted(
    _RegistrationSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final token = state.registrationToken;
    if (token == null) return;
    if (state.sessionStatus.isLoading) return;

    emit(state.copyWith(
      sessionStatus: const BlocStatus.loading(),
      routeToPhoneVerification: false,
    ));

    final result = await _facade.completeRegistration(
      registrationToken: token,
      name: event.name,
      phone: event.phone,
    );

    result.when(
      success: (session) => emit(state.copyWith(
        sessionStatus: BlocStatus.success(session),
        routeToPhoneVerification: event.verifyNow,
      )),
      failure: (message) =>
          emit(state.copyWith(sessionStatus: BlocStatus.failure(message))),
    );
  }

  void _handleOutcome(Emitter<AuthState> emit, AuthOutcome outcome) {
    switch (outcome) {
      case SessionOutcome(:final session):
        emit(state.copyWith(sessionStatus: BlocStatus.success(session)));
      case RegistrationOutcome(:final registrationToken, :final email, :final name):
        // Login mode: a registration challenge means no account exists for this identity.
        if (state.mode == AuthMode.login) {
          emit(state.copyWith(
            requestStatus: BlocStatus.failure(AuthStrings.authNoAccountTitle),
            sessionStatus: const BlocStatus.initial(),
          ));
          return;
        }
        emit(state.copyWith(
          step: AuthStep.registration,
          registrationToken: registrationToken,
          registrationEmail: email,
          registrationName: name,
          sessionStatus: const BlocStatus.initial(),
          requestStatus: const BlocStatus.initial(),
        ));
      case CancelledOutcome():
        emit(state.copyWith(
          requestStatus: const BlocStatus.initial(),
          sessionStatus: const BlocStatus.initial(),
        ));
    }
  }

  void _emitSession(Emitter<AuthState> emit, Result<AuthSession> result) {
    result.when(
      success: (session) =>
          emit(state.copyWith(sessionStatus: BlocStatus.success(session))),
      failure: (message) =>
          emit(state.copyWith(sessionStatus: BlocStatus.failure(message))),
    );
  }

  void _onBackRequested(_BackRequested event, Emitter<AuthState> emit) {
    _resendTimer?.cancel();
    switch (state.step) {
      case AuthStep.otp:
        emit(state.copyWith(
          step: state.otpContext == OtpContext.emailLogin ||
                  state.otpContext == OtpContext.emailSignup
              ? AuthStep.emailInput
              : AuthStep.phoneInput,
          sessionStatus: const BlocStatus.initial(),
          resendSeconds: 0,
        ));
      case AuthStep.phoneInput:
      case AuthStep.emailInput:
      case AuthStep.registration:
        emit(state.copyWith(
          step: AuthStep.landing,
          requestStatus: const BlocStatus.initial(),
          sessionStatus: const BlocStatus.initial(),
          resendSeconds: 0,
        ));
      case AuthStep.landing:
        emit(state.copyWith(step: AuthStep.intro));
      case AuthStep.intro:
        break;
    }
  }

  void _onResetRequested(_ResetRequested event, Emitter<AuthState> emit) {
    _resendTimer?.cancel();
    emit(AuthState(mode: state.mode));
  }

  void _onTick(_Tick event, Emitter<AuthState> emit) {
    final next = state.resendSeconds - 1;
    emit(state.copyWith(resendSeconds: next < 0 ? 0 : next));
    if (next <= 0) _resendTimer?.cancel();
  }

  void _startResendCountdown(Emitter<AuthState> emit, int seconds) {
    _resendTimer?.cancel();
    emit(state.copyWith(resendSeconds: seconds));
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const AuthEvent.tick());
    });
  }
}
