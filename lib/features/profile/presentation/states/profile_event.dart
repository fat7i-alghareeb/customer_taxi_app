part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.nameSaved(String name) = _NameSaved;
  const factory ProfileEvent.emailSaved(String email) = _EmailSaved;
  const factory ProfileEvent.photoSelected(File photo) = _PhotoSelected;
  const factory ProfileEvent.homeAddressMapPicked({
    required String label,
    required double latitude,
    required double longitude,
  }) = _HomeAddressMapPicked;
  const factory ProfileEvent.homeAddressLabelChanged(String? label) =
      _HomeAddressLabelChanged;
  const factory ProfileEvent.saveRequested() = _SaveRequested;
  const factory ProfileEvent.deleteAccountRequested() = _DeleteAccountRequested;
}
