// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_trip_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderTripResponseModel _$OrderTripResponseModelFromJson(
  Map<String, dynamic> json,
) => _OrderTripResponseModel(
  id: json['id'] as String,
  referenceCode: json['referenceCode'] as String,
  passengerId: json['passengerId'] as String,
  driverId: json['driverId'] as String?,
  vehicleTypeId: json['vehicleTypeId'] as String,
  status: json['status'] as String,
  quotedFare: (json['quotedFare'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
  scheduledAtUtc: json['scheduledAtUtc'] == null
      ? null
      : DateTime.parse(json['scheduledAtUtc'] as String),
  stops: (json['stops'] as List<dynamic>)
      .map((e) => OrderTripStopModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  stripePayment: json['stripePayment'] == null
      ? null
      : OrderStripePaymentModel.fromJson(
          json['stripePayment'] as Map<String, dynamic>,
        ),
  passengerNote: json['passengerNote'] as String?,
);

Map<String, dynamic> _$OrderTripResponseModelToJson(
  _OrderTripResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'referenceCode': instance.referenceCode,
  'passengerId': instance.passengerId,
  'driverId': instance.driverId,
  'vehicleTypeId': instance.vehicleTypeId,
  'status': instance.status,
  'quotedFare': instance.quotedFare,
  'currencyCode': instance.currencyCode,
  'createdAtUtc': instance.createdAtUtc.toIso8601String(),
  'scheduledAtUtc': instance.scheduledAtUtc?.toIso8601String(),
  'stops': instance.stops,
  'stripePayment': instance.stripePayment,
  'passengerNote': instance.passengerNote,
};
