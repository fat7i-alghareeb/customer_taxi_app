import 'dart:io';

class UpdateProfileParam {
  const UpdateProfileParam({required this.name});
  final String name;
  Map<String, dynamic> toJson() => {'name': name};
}

class UpdateProfilePhotoParam {
  const UpdateProfilePhotoParam({required this.photo});
  final File photo;
}
