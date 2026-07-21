/// What a committed edit actually cost the customer, surfaced so the app can confirm it.
///
/// Both settlement routes end here: the silent one (wallet / saved card, charged during
/// `edit/apply`) and the interactive one (Stripe PaymentSheet, committed later by the
/// webhook and announced over realtime). Before this existed the money moved with nothing
/// on screen to show for it, which is why customers reported being changed but not charged.
class TripEditSettlementEntity {
  const TripEditSettlementEntity({
    required this.delta,
    required this.currency,
    required this.newFare,
    required this.signalId,
  });

  /// New fare − old fare. Positive = charged, negative = refunded, 0 = no price change.
  final double delta;
  final String currency;

  /// The fare the trip carries after the edit.
  final double newFare;

  /// Distinguishes two settlements that happen to carry identical amounts, so a repeat
  /// edit still re-triggers the confirmation instead of looking like unchanged state.
  final int signalId;

  bool get isCharge => delta > 0;
  bool get isRefund => delta < 0;
  bool get isNoChange => delta == 0;

  double get absoluteDelta => delta.abs();
}
