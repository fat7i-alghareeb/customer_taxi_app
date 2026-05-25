// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_stripe_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderStripePaymentModel _$OrderStripePaymentModelFromJson(
  Map<String, dynamic> json,
) => _OrderStripePaymentModel(
  paymentIntentId: json['paymentIntentId'] as String,
  clientSecret: json['clientSecret'] as String,
  publishableKey: json['publishableKey'] as String,
  customerId: json['customerId'] as String,
  ephemeralKeySecret: json['ephemeralKeySecret'] as String,
);

Map<String, dynamic> _$OrderStripePaymentModelToJson(
  _OrderStripePaymentModel instance,
) => <String, dynamic>{
  'paymentIntentId': instance.paymentIntentId,
  'clientSecret': instance.clientSecret,
  'publishableKey': instance.publishableKey,
  'customerId': instance.customerId,
  'ephemeralKeySecret': instance.ephemeralKeySecret,
};
