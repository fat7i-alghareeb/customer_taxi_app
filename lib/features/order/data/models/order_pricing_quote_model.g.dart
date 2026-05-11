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
  capacity: (json['capacity'] as num?)?.toInt() ?? 0,
  totalDistanceKm: (json['totalDistanceKm'] as num).toDouble(),
  totalDurationMin: (json['totalDurationMin'] as num).toDouble(),
  originalFare: (json['originalFare'] as num?)?.toDouble() ?? 0.0,
  finalFare: (json['finalFare'] as num).toDouble(),
  discountPercent: (json['discountPercent'] as num?)?.toDouble() ?? 0.0,
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
  'capacity': instance.capacity,
  'totalDistanceKm': instance.totalDistanceKm,
  'totalDurationMin': instance.totalDurationMin,
  'originalFare': instance.originalFare,
  'finalFare': instance.finalFare,
  'discountPercent': instance.discountPercent,
  'currencyCode': instance.currencyCode,
  'validUntil': instance.validUntil.toIso8601String(),
};
