// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_otp_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OtpRequestResponseModel _$OtpRequestResponseModelFromJson(
  Map<String, dynamic> json,
) => _OtpRequestResponseModel(
  otpRequestId: json['otpRequestId'] as String,
  expiresInSeconds: (json['expiresInSeconds'] as num).toInt(),
  resendAvailableInSeconds: (json['resendAvailableInSeconds'] as num).toInt(),
);

Map<String, dynamic> _$OtpRequestResponseModelToJson(
  _OtpRequestResponseModel instance,
) => <String, dynamic>{
  'otpRequestId': instance.otpRequestId,
  'expiresInSeconds': instance.expiresInSeconds,
  'resendAvailableInSeconds': instance.resendAvailableInSeconds,
};

_RegistrationChallengeModel _$RegistrationChallengeModelFromJson(
  Map<String, dynamic> json,
) => _RegistrationChallengeModel(
  registrationToken: json['registrationToken'] as String,
  email: json['email'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$RegistrationChallengeModelToJson(
  _RegistrationChallengeModel instance,
) => <String, dynamic>{
  'registrationToken': instance.registrationToken,
  'email': instance.email,
  'name': instance.name,
};

_AuthResultModel _$AuthResultModelFromJson(Map<String, dynamic> json) =>
    _AuthResultModel(
      session: json['session'] == null
          ? null
          : AuthLoginResponseModel.fromJson(
              json['session'] as Map<String, dynamic>,
            ),
      registration: json['registration'] == null
          ? null
          : RegistrationChallengeModel.fromJson(
              json['registration'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AuthResultModelToJson(_AuthResultModel instance) =>
    <String, dynamic>{
      'session': instance.session,
      'registration': instance.registration,
    };
