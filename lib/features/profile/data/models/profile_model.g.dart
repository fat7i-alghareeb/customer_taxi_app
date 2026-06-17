// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      homeAddressLabel: json['homeAddressLabel'] as String?,
      homeAddressLatitude: (json['homeAddressLatitude'] as num?)?.toDouble(),
      homeAddressLongitude: (json['homeAddressLongitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'homeAddressLabel': instance.homeAddressLabel,
      'homeAddressLatitude': instance.homeAddressLatitude,
      'homeAddressLongitude': instance.homeAddressLongitude,
    };
