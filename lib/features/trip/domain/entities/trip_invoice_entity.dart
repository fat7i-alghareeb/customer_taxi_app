import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_invoice_entity.freezed.dart';

@freezed
abstract class TripInvoiceEntity with _$TripInvoiceEntity {
  const factory TripInvoiceEntity({
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
    @Default([]) List<TripInvoiceStopEntity> stops,
  }) = _TripInvoiceEntity;
}

@freezed
abstract class TripInvoiceStopEntity with _$TripInvoiceStopEntity {
  const factory TripInvoiceStopEntity({
    @Default(0) int sequence,
    String? label,
    DateTime? completedAtUtc,
  }) = _TripInvoiceStopEntity;
}
