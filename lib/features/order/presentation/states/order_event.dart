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

  const factory OrderEvent.setOnMapPressed(OrderLocationTarget target) =
      _SetOnMapPressed;

  const factory OrderEvent.mapCameraTargetUpdated({
    required double latitude,
    required double longitude,
    required double zoom,
  }) = _MapCameraTargetUpdated;

  const factory OrderEvent.confirmMapPointPressed() = _ConfirmMapPointPressed;

  const factory OrderEvent.fromQueryChanged(String query) = _FromQueryChanged;
  const factory OrderEvent.toQueryChanged(String query) = _ToQueryChanged;

  const factory OrderEvent.fromLocationCleared() = _FromLocationCleared;
  const factory OrderEvent.toLocationCleared() = _ToLocationCleared;

  const factory OrderEvent.fromSuggestionSelected(
    OrderSavedLocationEntity location,
  ) = _FromSuggestionSelected;

  const factory OrderEvent.toSuggestionSelected(
    OrderSavedLocationEntity location,
  ) = _ToSuggestionSelected;

  const factory OrderEvent.savedLocationPinToggled({
    required OrderLocationTarget target,
    required OrderSavedLocationEntity location,
  }) = _SavedLocationPinToggled;

  const factory OrderEvent.carTypeToggled(String typeId) = _CarTypeToggled;

  const factory OrderEvent.pickupStreetChanged(String value) =
      _PickupStreetChanged;
  const factory OrderEvent.pickupHouseNumberChanged(String value) =
      _PickupHouseNumberChanged;

  factory OrderEvent.tripPrefetchCompleted({
    required int token,
    required OrderLocationEntity fromLocation,
    required OrderLocationEntity toLocation,
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
}
