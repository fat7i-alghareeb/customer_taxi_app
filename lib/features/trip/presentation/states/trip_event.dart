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
  const factory TripEvent.stopsUpdateRequested(
    List<TripStopEntity> stops,
  ) = _StopsUpdateRequested;
  const factory TripEvent.passengerCountUpdateRequested(int count) =
      _PassengerCountUpdateRequested;
  const factory TripEvent.bagCountUpdateRequested(int count) =
      _BagCountUpdateRequested;
}
