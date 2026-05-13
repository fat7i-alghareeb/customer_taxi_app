part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(BlocStatus<void>.initial()) BlocStatus<void> phoneStatus,
    @Default(BlocStatus<UserEntity>.initial())
    BlocStatus<UserEntity> otpStatus,
    @Default(false) bool isOtpSent,
    @Default(true) bool isLanding,
    String? verificationId,
  }) = _AuthState;
}
