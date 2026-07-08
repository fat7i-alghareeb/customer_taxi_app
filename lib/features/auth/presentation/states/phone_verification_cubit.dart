import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/user_entity.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../domain/facade/auth_facade.dart';

class PhoneVerificationState {
  const PhoneVerificationState({
    this.requestStatus = const BlocStatus.initial(),
    this.verifyStatus = const BlocStatus.initial(),
    this.otpRequestId,
    this.otpSent = false,
    this.resendSeconds = 0,
  });

  final BlocStatus<void> requestStatus;
  final BlocStatus<UserEntity> verifyStatus;
  final String? otpRequestId;
  final bool otpSent;
  final int resendSeconds;

  PhoneVerificationState copyWith({
    BlocStatus<void>? requestStatus,
    BlocStatus<UserEntity>? verifyStatus,
    String? otpRequestId,
    bool? otpSent,
    int? resendSeconds,
  }) {
    return PhoneVerificationState(
      requestStatus: requestStatus ?? this.requestStatus,
      verifyStatus: verifyStatus ?? this.verifyStatus,
      otpRequestId: otpRequestId ?? this.otpRequestId,
      otpSent: otpSent ?? this.otpSent,
      resendSeconds: resendSeconds ?? this.resendSeconds,
    );
  }
}

@injectable
class PhoneVerificationCubit extends Cubit<PhoneVerificationState> {
  PhoneVerificationCubit(this._facade)
      : super(const PhoneVerificationState());

  final AuthFacade _facade;
  Timer? _timer;
  String? _pendingPhone;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> requestOtp(String phone) async {
    if (state.requestStatus.isLoading) return;
    _pendingPhone = phone;
    emit(state.copyWith(requestStatus: const BlocStatus.loading()));

    final result = await _facade.requestPhoneVerifyOtp(phone);
    result.when(
      success: (info) {
        emit(state.copyWith(
          requestStatus: const BlocStatus.success(null),
          otpSent: true,
          otpRequestId: info.otpRequestId,
          verifyStatus: const BlocStatus.initial(),
        ));
        _startCountdown(info.resendAvailableInSeconds);
      },
      failure: (message) => emit(
        state.copyWith(requestStatus: BlocStatus.failure(message)),
      ),
    );
  }

  Future<void> resend() async {
    if (state.resendSeconds > 0 || _pendingPhone == null) return;
    await requestOtp(_pendingPhone!);
  }

  Future<void> verify(String code) async {
    final id = state.otpRequestId;
    if (id == null || state.verifyStatus.isLoading) return;
    emit(state.copyWith(verifyStatus: const BlocStatus.loading()));

    final result = await _facade.verifyPhoneVerifyOtp(otpRequestId: id, code: code);
    result.when(
      success: (session) =>
          emit(state.copyWith(verifyStatus: BlocStatus.success(session.user))),
      failure: (message) =>
          emit(state.copyWith(verifyStatus: BlocStatus.failure(message))),
    );
  }

  void _startCountdown(int seconds) {
    _timer?.cancel();
    emit(state.copyWith(resendSeconds: seconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final next = state.resendSeconds - 1;
      emit(state.copyWith(resendSeconds: next < 0 ? 0 : next));
      if (next <= 0) _timer?.cancel();
    });
  }
}
