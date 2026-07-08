import 'package:freezed_annotation/freezed_annotation.dart';

import 'trip_model.dart';

part 'trip_receipt_model.freezed.dart';
part 'trip_receipt_model.g.dart';

@freezed
abstract class TripReceiptModel with _$TripReceiptModel {
  const factory TripReceiptModel({
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
    @Default([]) List<TripStopModel> stops,
    @Default(0) double waitingFeeAmount,
    @Default(0) double walletPaidAmount,
    @Default(0) double cardPaidAmount,
    @Default(0) double totalPaidAmount,
    @Default(0) double unpaidAmount,
    @Default(0) double refundedAmount,
  }) = _TripReceiptModel;

  factory TripReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$TripReceiptModelFromJson(json);
}
