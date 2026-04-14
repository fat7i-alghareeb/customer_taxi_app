part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.started() = _Started;
  const factory OrderEvent.getAllRequested() = _GetAllRequested;

  const factory OrderEvent.orderNowPressed() = _OrderNowPressed;
  const factory OrderEvent.collapseRequested() = _CollapseRequested;
  const factory OrderEvent.mapPickCancelled() = _MapPickCancelled;

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
    OrderLocationEntity location,
  ) = _FromSuggestionSelected;

  const factory OrderEvent.toSuggestionSelected(OrderLocationEntity location) =
      _ToSuggestionSelected;

  const factory OrderEvent.confirmOrderPressed() = _ConfirmOrderPressed;
}
