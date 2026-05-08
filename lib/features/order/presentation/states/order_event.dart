part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.started() = _Started;
  const factory OrderEvent.getAllRequested() = _GetAllRequested;

  const factory OrderEvent.orderNowPressed() = _OrderNowPressed;
  const factory OrderEvent.collapseRequested() = _CollapseRequested;
  const factory OrderEvent.mapPickCancelled() = _MapPickCancelled;
  const factory OrderEvent.vehicleStepBackPressed() = _VehicleStepBackPressed;
  const factory OrderEvent.pickupPointBackPressed() = _PickupPointBackPressed;

  const factory OrderEvent.setOnMapPressed() = _SetOnMapPressed;

  const factory OrderEvent.mapCameraTargetUpdated({
    required double latitude,
    required double longitude,
    required double zoom,
  }) = _MapCameraTargetUpdated;

  const factory OrderEvent.confirmMapPointPressed() = _ConfirmMapPointPressed;

  const factory OrderEvent.activeStopChanged(int index) = _ActiveStopChanged;
  const factory OrderEvent.stopQueryChanged(int index, String query) = _StopQueryChanged;
  const factory OrderEvent.stopCleared(int index) = _StopCleared;
  const factory OrderEvent.stopSuggestionSelected(
    int index,
    OrderSavedLocationEntity location,
  ) = _StopSuggestionSelected;

  const factory OrderEvent.stopAdded() = _StopAdded;
  const factory OrderEvent.stopRemoved(int index) = _StopRemoved;
  const factory OrderEvent.stopReordered(int oldIndex, int newIndex) = _StopReordered;

  const factory OrderEvent.savedLocationPinToggled({
    required int stopIndex,
    required OrderSavedLocationEntity location,
  }) = _SavedLocationPinToggled;

  const factory OrderEvent.carTypeToggled(String typeId) = _CarTypeToggled;

  const factory OrderEvent.pickupStreetChanged(String value) =
      _PickupStreetChanged;
  const factory OrderEvent.pickupHouseNumberChanged(String value) =
      _PickupHouseNumberChanged;

  factory OrderEvent.tripPrefetchCompleted({
    required int token,
    required List<OrderLocationEntity> stops,
    required BlocStatus<OrderTripRouteEntity> routeState,
    required BlocStatus<List<OrderTripCarOptionEntity>> pricingState,
  }) = _TripPrefetchCompleted;

  const factory OrderEvent.confirmOrderPressed() = _ConfirmOrderPressed;
  const factory OrderEvent.confirmCarSelectionPressed() =
      _ConfirmCarSelectionPressed;
  const factory OrderEvent.confirmPickupPointPressed() =
      _ConfirmPickupPointPressed;
  const factory OrderEvent.pickupConfirmationFeedbackCleared() =
      _PickupConfirmationFeedbackCleared;
  const factory OrderEvent.bookingDetailsBackPressed() =
      _BookingDetailsBackPressed;
  const factory OrderEvent.scheduleTimeChanged(DateTime? time) =
      _ScheduleTimeChanged;
  const factory OrderEvent.paymentMethodChanged(String methodId) =
      _PaymentMethodChanged;
  const factory OrderEvent.confirmBookingDetailsPressed() =
      _ConfirmBookingDetailsPressed;
}
