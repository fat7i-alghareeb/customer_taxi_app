import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/user_entity.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../domain/facade/auth_facade.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._facade) : super(const AuthState()) {
    on<_Started>(_onStarted);
    on<_SendOtpRequested>(_onSendOtpRequested);
    on<_VerifyOtpRequested>(_onVerifyOtpRequested);
    on<_ResetRequested>(_onResetRequested);
  }

  final AuthFacade _facade;

  // Phone stored between send-OTP and verify-OTP steps
  String? _pendingPhone;

  Future<void> _onStarted(_Started event, Emitter<AuthState> emit) async {
    _pendingPhone = null;
    emit(const AuthState());
  }

  Future<void> _onResetRequested(
    _ResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    _pendingPhone = null;
    emit(state.copyWith(
      isOtpSent: false,
      phoneStatus: const BlocStatus.initial(),
      otpStatus: const BlocStatus.initial(),
      sessionToken: null,
    ));
  }

  Future<void> _onSendOtpRequested(
    _SendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.phoneStatus.isLoading) return;
    emit(state.copyWith(phoneStatus: const BlocStatus.loading()));

    _pendingPhone = event.phone;
    final result = await _facade.sendOtp(event.phone);

    result.when(
      success: (sessionToken) => emit(state.copyWith(
        phoneStatus: const BlocStatus.success(null),
        isOtpSent: true,
        sessionToken: sessionToken,
      )),
      failure: (message) => emit(state.copyWith(
        phoneStatus: BlocStatus.failure(message),
      )),
    );
  }

  Future<void> _onVerifyOtpRequested(
    _VerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.otpStatus.isLoading) return;
    if (_pendingPhone == null || state.sessionToken == null) return;

    emit(state.copyWith(otpStatus: const BlocStatus.loading()));

    final result = await _facade.verifyOtp(
      phone: _pendingPhone!,
      sessionToken: state.sessionToken!,
      code: event.otp,
    );

    result.when(
      success: (user) =>
          emit(state.copyWith(otpStatus: BlocStatus.success(user))),
      failure: (message) =>
          emit(state.copyWith(otpStatus: BlocStatus.failure(message))),
    );
  }
}
