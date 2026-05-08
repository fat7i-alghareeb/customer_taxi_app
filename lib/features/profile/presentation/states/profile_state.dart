part of 'profile_bloc.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(BlocStatus<ProfileEntity>.initial())
    BlocStatus<ProfileEntity> loadStatus,

    @Default(BlocStatus<ProfileEntity>.initial())
    BlocStatus<ProfileEntity> saveStatus,

    ProfileEntity? currentUser,
    @Default('') String pendingName,
    File? pendingPhoto,
  }) = _ProfileState;
}
