part of 'order_bloc.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState({
    @Default(BlocStatus<List<OrderEntity>>.initial())
    BlocStatus<List<OrderEntity>> getAllState,

    @Default(OrderSheetMode.collapsed) OrderSheetMode sheetMode,

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
  }) = _OrderState;
}
