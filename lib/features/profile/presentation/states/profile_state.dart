part of 'profile_bloc.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(BlocStatus<ProfileEntity>.initial())
    BlocStatus<ProfileEntity> loadStatus,

    @Default(BlocStatus<ProfileEntity>.initial())
    BlocStatus<ProfileEntity> saveStatus,

    @Default(BlocStatus<void>.initial()) BlocStatus<void> deleteAccountStatus,

    ProfileEntity? currentUser,
    @Default('') String pendingName,
    @Default('') String pendingEmail,
    File? pendingPhoto,
    // Pending home address selection. `homeAddressTouched` distinguishes "not
    // changed" (keep current) from "cleared" (all values null → remove).
    @Default(false) bool homeAddressTouched,
    String? pendingHomeAddressLabel,
    double? pendingHomeAddressLatitude,
    double? pendingHomeAddressLongitude,
  }) = _ProfileState;
}
