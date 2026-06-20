import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    String? name,
    required String phone,
    String? email,
    String? profilePhotoUrl,
    String? homeAddressLabel,
    double? homeAddressLatitude,
    double? homeAddressLongitude,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
