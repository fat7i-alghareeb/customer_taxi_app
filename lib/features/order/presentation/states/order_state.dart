part of 'order_bloc.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState({
    @Default(BlocStatus<List<OrderEntity>>.initial())
    BlocStatus<List<OrderEntity>> getAllState,

    @Default(OrderSheetMode.collapsed) OrderSheetMode sheetMode,

    @Default(OrderExpandedStep.locationEntry) OrderExpandedStep expandedStep,

    @Default(OrderLocationTarget.stop) OrderLocationTarget mapPickingTarget,

    @Default(MapConfig.defaultLat) double mapCameraLatitude,
    @Default(MapConfig.defaultLng) double mapCameraLongitude,
    @Default(MapConfig.initialZoom) double mapCameraZoom,

    @Default([null, null]) List<OrderLocationEntity?> stops,
    @Default(['', '']) List<String> stopQueries,
    @Default([
      BlocStatus<List<OrderSavedLocationEntity>>.initial(),
      BlocStatus<List<OrderSavedLocationEntity>>.initial(),
    ])
    List<BlocStatus<List<OrderSavedLocationEntity>>> stopSuggestionsState,

    @Default(0) int activeStopIndex,

    @Default(BlocStatus<List<OrderSavedLocationEntity>>.initial())
    BlocStatus<List<OrderSavedLocationEntity>> savedLocationsState,

    @Default(BlocStatus<OrderLocationEntity>.initial())
    BlocStatus<OrderLocationEntity> pickupPointState,

    @Default('') String pickupStreetName,
    @Default('') String pickupHouseNumber,

    @Default(BlocStatus<String>.initial())
    BlocStatus<String> pickupConfirmationFeedbackState,

    @Default(BlocStatus<OrderTripRouteEntity>.initial())
    BlocStatus<OrderTripRouteEntity> tripRouteState,

    @Default(BlocStatus<List<OrderTripCarOptionEntity>>.initial())
    BlocStatus<List<OrderTripCarOptionEntity>> tripCarOptionsState,

    @Default(BlocStatus<OrderTripRouteEntity>.initial())
    BlocStatus<OrderTripRouteEntity> prefetchedTripRouteState,

    @Default(BlocStatus<List<OrderTripCarOptionEntity>>.initial())
    BlocStatus<List<OrderTripCarOptionEntity>> prefetchedTripCarOptionsState,

    @Default([]) List<OrderLocationEntity> prefetchedStops,

    String? selectedCarTypeId,
    String? selectedQuoteId,
    DateTime? scheduledAt,
    String? paymentMethodId,

    @Default(BlocStatus<OrderTripResponseEntity>.initial())
    BlocStatus<OrderTripResponseEntity> tripRequestStatus,
  }) = _OrderState;
}
