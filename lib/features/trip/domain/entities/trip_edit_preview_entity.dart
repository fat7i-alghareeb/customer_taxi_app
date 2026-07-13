/// The re-priced preview of a proposed destination / passenger change, before it is applied.
/// [direction] is `charge` (customer pays [delta] more), `refund` (gets |[delta]| back) or `none`.
class TripEditPreviewEntity {
  const TripEditPreviewEntity({
    required this.oldFinalFare,
    required this.newFinalFare,
    required this.delta,
    required this.currency,
    required this.effectivePassengerCount,
    required this.direction,
    this.newVehicleTypeId,
    this.newVehicleTypeName,
  });

  final double oldFinalFare;
  final double newFinalFare;

  /// New fare − old fare. Positive = charge, negative = refund.
  final double delta;
  final String currency;
  final int effectivePassengerCount;
  final String direction;
  final String? newVehicleTypeId;
  final String? newVehicleTypeName;

  bool get isCharge => direction == 'charge';
  bool get isRefund => direction == 'refund';
  bool get isNoChange => direction == 'none';

  /// Absolute difference, always positive (amount to pay or to be refunded).
  double get absoluteDelta => delta.abs();

  /// True when the re-quote switched to a different vehicle (e.g. a passenger up/downgrade).
  bool get vehicleChanged =>
      newVehicleTypeId != null && (newVehicleTypeName?.isNotEmpty ?? false);
}
