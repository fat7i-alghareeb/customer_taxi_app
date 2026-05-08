import 'dart:io';

class UpdateUserProfileRequest {
  const UpdateUserProfileRequest({
    this.name,
    this.photo,
  });

  final String? name;
  final File? photo;
}
