part of 'trip_bloc.dart';

@freezed
class TripEvent with _$TripEvent {
  const factory TripEvent.started(String tripId) = _Started;
  const factory TripEvent.pollingTick() = _PollingTick;
  const factory TripEvent.cancelRequested({String? note}) = _CancelRequested;
  const factory TripEvent.passengerNoteSubmitted(String? passengerNote) =
      _PassengerNoteSubmitted;
  const factory TripEvent.compensationClaimSubmitted({
    required String note,
    @Default([]) List<String> evidenceUrls,
  }) = _CompensationClaimSubmitted;
  const factory TripEvent.stopPolling() = _StopPolling;
  const factory TripEvent.historyStarted() = _HistoryStarted;
  const factory TripEvent.searchChanged(String query) = _SearchChanged;
  const factory TripEvent.nextPageRequested() = _NextPageRequested;
  const factory TripEvent.driverLocationUpdated(
    double latitude,
    double longitude, {
    int? etaToPickupSeconds,
    int? distanceToPickupMeters,
    String? routeToPickupPolyline,
  }) = _DriverLocationUpdated;
  const factory TripEvent.loadReceipt(String tripId) = _LoadReceipt;
  const factory TripEvent.loadInvoice(String tripId) = _LoadInvoice;
  const factory TripEvent.loadInvoicePdf({
    required String tripId,
    required String languageCode,
  }) = _LoadInvoicePdf;
  const factory TripEvent.scheduledTimeUpdateRequested(
    DateTime? scheduledAtUtc,
  ) = _ScheduledTimeUpdateRequested;
  /// Preview the fare difference for a proposed destination / passenger change
  /// (no mutation). Drives the confirmation dialog.
  const factory TripEvent.editPreviewRequested({
    List<TripStopEntity>? stops,
    int? passengerCount,
  }) = _EditPreviewRequested;

  /// Apply a previewed change and settle the fare difference. [previewToken] pins the
  /// server to the quote the customer saw, so the amount charged matches the amount
  /// confirmed; [expectedDelta] remains the guard for the tokenless path.
  const factory TripEvent.editApplyRequested({
    List<TripStopEntity>? stops,
    int? passengerCount,
    required double expectedDelta,
    String? previewToken,
  }) = _EditApplyRequested;

  /// A re-priced edit landed server-side (realtime `TripEditApplied`), including the one
  /// committed by the Stripe webhook after the PaymentSheet. Refreshes the trip and
  /// surfaces what the change cost.
  const factory TripEvent.editAppliedReceived({
    required double newFare,
    required String currency,
    required double delta,
  }) = _EditAppliedReceived;

  /// Clears the last edit preview/apply status (e.g. after a dialog is dismissed).
  const factory TripEvent.editStatusReset() = _EditStatusReset;

  /// The settlement confirmation has been shown; drop it so it isn't shown twice.
  const factory TripEvent.editSettlementAcknowledged() =
      _EditSettlementAcknowledged;
  const factory TripEvent.bagCountUpdateRequested(int count) =
      _BagCountUpdateRequested;
  const factory TripEvent.noDriverPostponeRequested() =
      _NoDriverPostponeRequested;
  const factory TripEvent.noDriverCancelRequested({String? note}) =
      _NoDriverCancelRequested;
}
