// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripInvoiceModel _$TripInvoiceModelFromJson(Map<String, dynamic> json) =>
    _TripInvoiceModel(
      invoiceId: json['invoiceId'] as String,
      tripId: json['tripId'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      issuedAtUtc: DateTime.parse(json['issuedAtUtc'] as String),
      currencyCode: json['currencyCode'] as String,
      grossAmount: (json['grossAmount'] as num).toDouble(),
      netAmount: (json['netAmount'] as num).toDouble(),
      taxRate: (json['taxRate'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      paymentReference: json['paymentReference'] as String?,
      paidAtUtc: json['paidAtUtc'] == null
          ? null
          : DateTime.parse(json['paidAtUtc'] as String),
      issuerName: json['issuerName'] as String,
      issuerAddress: json['issuerAddress'] as String,
      issuerVatNumber: json['issuerVatNumber'] as String?,
      tripReferenceCode: json['tripReferenceCode'] as String,
      tripCompletedAtUtc: json['tripCompletedAtUtc'] == null
          ? null
          : DateTime.parse(json['tripCompletedAtUtc'] as String),
      distanceKm: (json['distanceKm'] as num).toDouble(),
      durationMin: (json['durationMin'] as num).toDouble(),
      vehicleTypeName: json['vehicleTypeName'] as String,
      passengerName: json['passengerName'] as String?,
      stops:
          (json['stops'] as List<dynamic>?)
              ?.map(
                (e) => TripInvoiceStopModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TripInvoiceModelToJson(_TripInvoiceModel instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'tripId': instance.tripId,
      'invoiceNumber': instance.invoiceNumber,
      'issuedAtUtc': instance.issuedAtUtc.toIso8601String(),
      'currencyCode': instance.currencyCode,
      'grossAmount': instance.grossAmount,
      'netAmount': instance.netAmount,
      'taxRate': instance.taxRate,
      'taxAmount': instance.taxAmount,
      'paymentMethod': instance.paymentMethod,
      'paymentReference': instance.paymentReference,
      'paidAtUtc': instance.paidAtUtc?.toIso8601String(),
      'issuerName': instance.issuerName,
      'issuerAddress': instance.issuerAddress,
      'issuerVatNumber': instance.issuerVatNumber,
      'tripReferenceCode': instance.tripReferenceCode,
      'tripCompletedAtUtc': instance.tripCompletedAtUtc?.toIso8601String(),
      'distanceKm': instance.distanceKm,
      'durationMin': instance.durationMin,
      'vehicleTypeName': instance.vehicleTypeName,
      'passengerName': instance.passengerName,
      'stops': instance.stops,
    };

_TripInvoiceStopModel _$TripInvoiceStopModelFromJson(
  Map<String, dynamic> json,
) => _TripInvoiceStopModel(
  sequence: (json['sequence'] as num?)?.toInt() ?? 0,
  label: json['label'] as String?,
  completedAtUtc: json['completedAtUtc'] == null
      ? null
      : DateTime.parse(json['completedAtUtc'] as String),
);

Map<String, dynamic> _$TripInvoiceStopModelToJson(
  _TripInvoiceStopModel instance,
) => <String, dynamic>{
  'sequence': instance.sequence,
  'label': instance.label,
  'completedAtUtc': instance.completedAtUtc?.toIso8601String(),
};
