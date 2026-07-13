import 'trip_entity.dart';
import 'waiting_fee_settlement_entity.dart';

/// Outcome of applying a mid-trip edit.
///
/// - [status] `applied`: the change is committed — [trip] carries the updated trip.
/// - [status] `requiresPaymentSheet`: a fare increase couldn't be charged silently; the trip is
///   UNCHANGED and [paymentSheet] must be presented. On success the backend applies the held edit
///   (a realtime refresh follows); on cancel/decline it reverts (nothing changes).
class TripEditApplyResultEntity {
  const TripEditApplyResultEntity({
    required this.status,
    required this.delta,
    required this.currency,
    this.trip,
    this.pendingEditId,
    this.paymentSheet,
  });

  final String status;
  final double delta;
  final String currency;
  final TripEntity? trip;
  final String? pendingEditId;
  final WaitingFeeStripePaymentEntity? paymentSheet;

  bool get isApplied => status == 'applied';
  bool get requiresPaymentSheet =>
      status == 'requiresPaymentSheet' && paymentSheet != null;
}
