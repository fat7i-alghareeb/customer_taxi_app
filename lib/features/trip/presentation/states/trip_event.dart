part of 'trip_bloc.dart';

@freezed
class TripEvent with _$TripEvent {
  const factory TripEvent.started(String tripId) = _Started;
  const factory TripEvent.pollingTick() = _PollingTick;
  const factory TripEvent.cancelRequested() = _CancelRequested;
  const factory TripEvent.passengerNoteSubmitted(String? passengerNote) =
      _PassengerNoteSubmitted;
  const factory TripEvent.compensationClaimSubmitted({
    required String note,
    @Default([]) List<String> evidenceUrls,
  }) = _CompensationClaimSubmitted;
  const factory TripEvent.stopPolling() = _StopPolling;
  const factory TripEvent.historyStarted() = _HistoryStarted;
  const factory TripEvent.nextPageRequested() = _NextPageRequested;
  const factory TripEvent.driverLocationUpdated(double latitude, double longitude) = _DriverLocationUpdated;
  const factory TripEvent.loadReceipt(String tripId) = _LoadReceipt;
  const factory TripEvent.loadInvoice(String tripId) = _LoadInvoice;
  const factory TripEvent.loadInvoicePdf({
    required String tripId,
    required String languageCode,
  }) = _LoadInvoicePdf;
}
