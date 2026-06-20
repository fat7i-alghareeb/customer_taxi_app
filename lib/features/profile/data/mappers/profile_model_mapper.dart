import '../../domain/entities/profile_entity.dart';
import '../models/profile_model.dart';

extension ProfileModelMapper on ProfileModel {
  ProfileEntity get toEntity => ProfileEntity(
    id: id,
    name: name,
    phone: phone,
    email: email,
    profilePhotoUrl: profilePhotoUrl,
    homeAddressLabel: homeAddressLabel,
    homeAddressLatitude: homeAddressLatitude,
    homeAddressLongitude: homeAddressLongitude,
  );
}
