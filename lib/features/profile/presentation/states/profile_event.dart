part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.nameSaved(String name) = _NameSaved;
  const factory ProfileEvent.photoSelected(File photo) = _PhotoSelected;
  const factory ProfileEvent.saveRequested() = _SaveRequested;
}
