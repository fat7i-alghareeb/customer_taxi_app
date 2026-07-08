// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthLoginResponseModel _$AuthLoginResponseModelFromJson(
  Map<String, dynamic> json,
) => _AuthLoginResponseModel(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  user: AuthUserModel.fromJson(json['user'] as Map<String, dynamic>),
  isNewAccount: json['isNewAccount'] as bool? ?? false,
  accountAlreadyExists: json['accountAlreadyExists'] as bool? ?? false,
);

Map<String, dynamic> _$AuthLoginResponseModelToJson(
  _AuthLoginResponseModel instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'user': instance.user,
  'isNewAccount': instance.isNewAccount,
  'accountAlreadyExists': instance.accountAlreadyExists,
};

_AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) =>
    _AuthUserModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? true,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$AuthUserModelToJson(_AuthUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'isPhoneVerified': instance.isPhoneVerified,
      'isEmailVerified': instance.isEmailVerified,
    };
