import 'package:freezed_annotation/freezed_annotation.dart';

import 'trip_entity.dart';

part 'trip_receipt_entity.freezed.dart';

@freezed
abstract class TripReceiptEntity with _$TripReceiptEntity {
  const factory TripReceiptEntity({
    required String tripId,
    required String referenceCode,
    required String status,
    required double grossAmount,
    required double netAmount,
    required double taxAmount,
    required String currencyCode,
    required String paymentMethod,
    String? paymentReference,
    DateTime? paidAtUtc,
    DateTime? completedAtUtc,
    required double distanceKm,
    required double durationMin,
    required String vehicleTypeName,
    String? passengerName,
    required String issuerName,
    required bool invoiceAvailable,
    String? invoiceNumber,
    DateTime? invoiceIssuedAtUtc,
    @Default([]) List<TripStopEntity> stops,
  }) = _TripReceiptEntity;
}
