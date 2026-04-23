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
    on<_LoginRequested>(_onLoginRequested);
    on<_SendOtpRequested>(_onSendOtpRequested);
    on<_VerifyOtpRequested>(_onVerifyOtpRequested);
    on<_ResetRequested>(_onResetRequested);
  }

  final AuthFacade _facade;

  Future<void> _onStarted(_Started event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      loginStatus: const BlocStatus.initial(),
      phoneStatus: const BlocStatus.initial(),
      otpStatus: const BlocStatus.initial(),
      isOtpSent: false,
    ));
  }

  Future<void> _onResetRequested(
    _ResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      isOtpSent: false,
      phoneStatus: const BlocStatus.initial(),
      otpStatus: const BlocStatus.initial(),
    ));
  }

  Future<void> _onSendOtpRequested(
    _SendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(phoneStatus: const BlocStatus.loading()));

    // Dummy delay to simulate network call
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(
      phoneStatus: const BlocStatus.success(null),
      isOtpSent: true,
    ));
  }

  Future<void> _onVerifyOtpRequested(
    _VerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(otpStatus: const BlocStatus.loading()));

    // Dummy delay
    await Future.delayed(const Duration(seconds: 1));

    if (event.otp == '0000') {
      emit(state.copyWith(otpStatus: const BlocStatus.success(null)));
      add(const AuthEvent.loginRequested());
    } else {
      emit(state.copyWith(
        otpStatus: const BlocStatus.failure('invalidOtp'),
      ));
    }
  }

  Future<void> _onLoginRequested(
    _LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.loginStatus.isLoading) return;

    emit(state.copyWith(loginStatus: const BlocStatus.loading()));

    final Result<UserEntity> result = await _facade.loginDummy();
    result.when(
      success: (user) =>
          emit(state.copyWith(loginStatus: BlocStatus.success(user))),
      failure: (message) =>
          emit(state.copyWith(loginStatus: BlocStatus.failure(message))),
    );
  }
}
