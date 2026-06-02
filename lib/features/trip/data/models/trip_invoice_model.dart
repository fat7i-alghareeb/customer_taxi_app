import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_invoice_model.freezed.dart';
part 'trip_invoice_model.g.dart';

@freezed
abstract class TripInvoiceModel with _$TripInvoiceModel {
  const factory TripInvoiceModel({
    required String invoiceId,
    required String tripId,
    required String invoiceNumber,
    required DateTime issuedAtUtc,
    required String currencyCode,
    required double grossAmount,
    required double netAmount,
    required double taxRate,
    required double taxAmount,
    required String paymentMethod,
    String? paymentReference,
    DateTime? paidAtUtc,
    required String issuerName,
    required String issuerAddress,
    String? issuerVatNumber,
    required String tripReferenceCode,
    DateTime? tripCompletedAtUtc,
    required double distanceKm,
    required double durationMin,
    required String vehicleTypeName,
    String? passengerName,
    @Default([]) List<TripInvoiceStopModel> stops,
  }) = _TripInvoiceModel;

  factory TripInvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$TripInvoiceModelFromJson(json);
}

@freezed
abstract class TripInvoiceStopModel with _$TripInvoiceStopModel {
  const factory TripInvoiceStopModel({
    @Default(0) int sequence,
    String? label,
    DateTime? completedAtUtc,
  }) = _TripInvoiceStopModel;

  factory TripInvoiceStopModel.fromJson(Map<String, dynamic> json) =>
      _$TripInvoiceStopModelFromJson(json);
}
