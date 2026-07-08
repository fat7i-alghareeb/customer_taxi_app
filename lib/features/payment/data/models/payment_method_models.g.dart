// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentMethodModel _$PaymentMethodModelFromJson(Map<String, dynamic> json) =>
    _PaymentMethodModel(
      id: json['id'] as String,
      cardBrand: json['cardBrand'] as String,
      lastFour: json['lastFour'] as String,
      expiryMonth: (json['expiryMonth'] as num).toInt(),
      expiryYear: (json['expiryYear'] as num).toInt(),
      cardholderName: json['cardholderName'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$PaymentMethodModelToJson(_PaymentMethodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardBrand': instance.cardBrand,
      'lastFour': instance.lastFour,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear,
      'cardholderName': instance.cardholderName,
      'isDefault': instance.isDefault,
    };

_PaymentMethodSetupModel _$PaymentMethodSetupModelFromJson(
  Map<String, dynamic> json,
) => _PaymentMethodSetupModel(
  setupIntentId: json['setupIntentId'] as String,
  clientSecret: json['clientSecret'] as String,
  publishableKey: json['publishableKey'] as String,
  customerId: json['customerId'] as String,
  ephemeralKeySecret: json['ephemeralKeySecret'] as String,
);

Map<String, dynamic> _$PaymentMethodSetupModelToJson(
  _PaymentMethodSetupModel instance,
) => <String, dynamic>{
  'setupIntentId': instance.setupIntentId,
  'clientSecret': instance.clientSecret,
  'publishableKey': instance.publishableKey,
  'customerId': instance.customerId,
  'ephemeralKeySecret': instance.ephemeralKeySecret,
};

_PaymentPreferenceModel _$PaymentPreferenceModelFromJson(
  Map<String, dynamic> json,
) => _PaymentPreferenceModel(
  preferredMethodType: json['preferredMethodType'] as String?,
  enabledMethodTypes:
      (json['enabledMethodTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$PaymentPreferenceModelToJson(
  _PaymentPreferenceModel instance,
) => <String, dynamic>{
  'preferredMethodType': instance.preferredMethodType,
  'enabledMethodTypes': instance.enabledMethodTypes,
};

_AddPaymentMethodRequestModel _$AddPaymentMethodRequestModelFromJson(
  Map<String, dynamic> json,
) => _AddPaymentMethodRequestModel(
  paymentMethodId: json['paymentMethodId'] as String,
  setAsDefault: json['setAsDefault'] as bool? ?? false,
);

Map<String, dynamic> _$AddPaymentMethodRequestModelToJson(
  _AddPaymentMethodRequestModel instance,
) => <String, dynamic>{
  'paymentMethodId': instance.paymentMethodId,
  'setAsDefault': instance.setAsDefault,
};
