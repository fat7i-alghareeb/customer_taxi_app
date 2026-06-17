import 'dart:io';

class UpdateUserProfileRequest {
  const UpdateUserProfileRequest({
    this.name,
    this.photo,
    this.homeAddressLabel,
    this.homeAddressLatitude,
    this.homeAddressLongitude,
  });

  final String? name;
  final File? photo;
  final String? homeAddressLabel;
  final double? homeAddressLatitude;
  final double? homeAddressLongitude;
}
