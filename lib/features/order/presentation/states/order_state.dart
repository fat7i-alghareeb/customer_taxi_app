part of 'order_bloc.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState({
    @Default(BlocStatus<List<OrderEntity>>.initial())
    BlocStatus<List<OrderEntity>> getAllState,

    @Default(OrderSheetMode.collapsed) OrderSheetMode sheetMode,

    @Default(OrderExpandedStep.locationEntry) OrderExpandedStep expandedStep,

    @Default(OrderLocationTarget.from) OrderLocationTarget mapPickingTarget,

    @Default(MapConfig.defaultLat) double mapCameraLatitude,
    @Default(MapConfig.defaultLng) double mapCameraLongitude,
    @Default(MapConfig.initialZoom) double mapCameraZoom,

    @Default(BlocStatus<OrderLocationEntity>.initial())
    BlocStatus<OrderLocationEntity> fromLocationState,

    @Default(BlocStatus<OrderLocationEntity>.initial())
    BlocStatus<OrderLocationEntity> toLocationState,

    @Default(BlocStatus<List<OrderLocationEntity>>.initial())
    BlocStatus<List<OrderLocationEntity>> fromSuggestionsState,

    @Default(BlocStatus<List<OrderLocationEntity>>.initial())
    BlocStatus<List<OrderLocationEntity>> toSuggestionsState,

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

    OrderLocationEntity? prefetchedFromLocation,
    OrderLocationEntity? prefetchedToLocation,

    String? selectedCarTypeId,
  }) = _OrderState;
}
