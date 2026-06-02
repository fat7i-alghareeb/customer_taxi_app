// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripReceiptModel _$TripReceiptModelFromJson(Map<String, dynamic> json) =>
    _TripReceiptModel(
      tripId: json['tripId'] as String,
      referenceCode: json['referenceCode'] as String,
      status: json['status'] as String,
      grossAmount: (json['grossAmount'] as num).toDouble(),
      netAmount: (json['netAmount'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
      paymentMethod: json['paymentMethod'] as String,
      paymentReference: json['paymentReference'] as String?,
      paidAtUtc: json['paidAtUtc'] == null
          ? null
          : DateTime.parse(json['paidAtUtc'] as String),
      completedAtUtc: json['completedAtUtc'] == null
          ? null
          : DateTime.parse(json['completedAtUtc'] as String),
      distanceKm: (json['distanceKm'] as num).toDouble(),
      durationMin: (json['durationMin'] as num).toDouble(),
      vehicleTypeName: json['vehicleTypeName'] as String,
      passengerName: json['passengerName'] as String?,
      issuerName: json['issuerName'] as String,
      invoiceAvailable: json['invoiceAvailable'] as bool,
      invoiceNumber: json['invoiceNumber'] as String?,
      invoiceIssuedAtUtc: json['invoiceIssuedAtUtc'] == null
          ? null
          : DateTime.parse(json['invoiceIssuedAtUtc'] as String),
      stops:
          (json['stops'] as List<dynamic>?)
              ?.map((e) => TripStopModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TripReceiptModelToJson(_TripReceiptModel instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'referenceCode': instance.referenceCode,
      'status': instance.status,
      'grossAmount': instance.grossAmount,
      'netAmount': instance.netAmount,
      'taxAmount': instance.taxAmount,
      'currencyCode': instance.currencyCode,
      'paymentMethod': instance.paymentMethod,
      'paymentReference': instance.paymentReference,
      'paidAtUtc': instance.paidAtUtc?.toIso8601String(),
      'completedAtUtc': instance.completedAtUtc?.toIso8601String(),
      'distanceKm': instance.distanceKm,
      'durationMin': instance.durationMin,
      'vehicleTypeName': instance.vehicleTypeName,
      'passengerName': instance.passengerName,
      'issuerName': instance.issuerName,
      'invoiceAvailable': instance.invoiceAvailable,
      'invoiceNumber': instance.invoiceNumber,
      'invoiceIssuedAtUtc': instance.invoiceIssuedAtUtc?.toIso8601String(),
      'stops': instance.stops,
    };
