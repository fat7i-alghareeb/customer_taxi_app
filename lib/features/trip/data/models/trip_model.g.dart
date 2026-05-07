// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripModel _$TripModelFromJson(Map<String, dynamic> json) => _TripModel(
  id: json['id'] as String,
  referenceCode: json['referenceCode'] as String,
  status: json['status'] as String,
  quotedFare: (json['quotedFare'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
  scheduledAtUtc: json['scheduledAtUtc'] == null
      ? null
      : DateTime.parse(json['scheduledAtUtc'] as String),
  stops:
      (json['stops'] as List<dynamic>?)
          ?.map((e) => TripStopModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TripModelToJson(_TripModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'referenceCode': instance.referenceCode,
      'status': instance.status,
      'quotedFare': instance.quotedFare,
      'currencyCode': instance.currencyCode,
      'createdAtUtc': instance.createdAtUtc.toIso8601String(),
      'scheduledAtUtc': instance.scheduledAtUtc?.toIso8601String(),
      'stops': instance.stops,
    };

_TripStopModel _$TripStopModelFromJson(Map<String, dynamic> json) =>
    _TripStopModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$TripStopModelToJson(_TripStopModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_TripSummaryModel _$TripSummaryModelFromJson(Map<String, dynamic> json) =>
    _TripSummaryModel(
      id: json['id'] as String,
      referenceCode: json['referenceCode'] as String,
      status: json['status'] as String,
      quotedFare: (json['quotedFare'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
      createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
      scheduledAtUtc: json['scheduledAtUtc'] == null
          ? null
          : DateTime.parse(json['scheduledAtUtc'] as String),
      stops:
          (json['stops'] as List<dynamic>?)
              ?.map((e) => TripStopModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TripSummaryModelToJson(_TripSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'referenceCode': instance.referenceCode,
      'status': instance.status,
      'quotedFare': instance.quotedFare,
      'currencyCode': instance.currencyCode,
      'createdAtUtc': instance.createdAtUtc.toIso8601String(),
      'scheduledAtUtc': instance.scheduledAtUtc?.toIso8601String(),
      'stops': instance.stops,
    };
