part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(BlocStatus<UserEntity>.initial())
    BlocStatus<UserEntity> loginStatus,
    @Default(BlocStatus<void>.initial())
    BlocStatus<void> phoneStatus,
    @Default(BlocStatus<void>.initial())
    BlocStatus<void> otpStatus,
    @Default(false) bool isOtpSent,
  }) = _AuthState;
}
