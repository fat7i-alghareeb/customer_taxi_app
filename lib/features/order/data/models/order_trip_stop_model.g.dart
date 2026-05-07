// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_trip_stop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderTripStopModel _$OrderTripStopModelFromJson(Map<String, dynamic> json) =>
    _OrderTripStopModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderTripStopModelToJson(_OrderTripStopModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
