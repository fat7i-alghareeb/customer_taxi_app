import 'dart:io';

enum HomeAddressOperation { keep, set, clear }

class UpdateUserProfileRequest {
  const UpdateUserProfileRequest({
    this.name,
    this.email,
    this.photo,
    this.homeAddressOperation = HomeAddressOperation.keep,
    this.homeAddressLabel,
    this.homeAddressLatitude,
    this.homeAddressLongitude,
  });

  final String? name;
  final String? email;
  final File? photo;
  final HomeAddressOperation homeAddressOperation;
  final String? homeAddressLabel;
  final double? homeAddressLatitude;
  final double? homeAddressLongitude;
}
