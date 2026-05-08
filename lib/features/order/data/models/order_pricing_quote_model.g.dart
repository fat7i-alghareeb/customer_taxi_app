// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_pricing_quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderPricingQuoteModel _$OrderPricingQuoteModelFromJson(
  Map<String, dynamic> json,
) => _OrderPricingQuoteModel(
  quoteId: json['quoteId'] as String,
  vehicleTypeId: json['vehicleTypeId'] as String,
  vehicleTypeCode: json['vehicleTypeCode'] as String?,
  vehicleTypeName: json['vehicleTypeName'] as String,
  totalDistanceKm: (json['totalDistanceKm'] as num).toDouble(),
  totalDurationMin: (json['totalDurationMin'] as num).toDouble(),
  finalFare: (json['finalFare'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  validUntil: DateTime.parse(json['validUntil'] as String),
);

Map<String, dynamic> _$OrderPricingQuoteModelToJson(
  _OrderPricingQuoteModel instance,
) => <String, dynamic>{
  'quoteId': instance.quoteId,
  'vehicleTypeId': instance.vehicleTypeId,
  'vehicleTypeCode': instance.vehicleTypeCode,
  'vehicleTypeName': instance.vehicleTypeName,
  'totalDistanceKm': instance.totalDistanceKm,
  'totalDurationMin': instance.totalDurationMin,
  'finalFare': instance.finalFare,
  'currencyCode': instance.currencyCode,
  'validUntil': instance.validUntil.toIso8601String(),
};
