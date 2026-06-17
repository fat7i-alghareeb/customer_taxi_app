import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';

@freezed
abstract class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String id,
    String? name,
    required String phone,
    String? profilePhotoUrl,
    String? homeAddressLabel,
    double? homeAddressLatitude,
    double? homeAddressLongitude,
  }) = _ProfileEntity;
}
