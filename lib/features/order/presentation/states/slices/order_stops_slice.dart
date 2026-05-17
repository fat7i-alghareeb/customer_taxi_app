import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_saved_location_entity.dart';

part 'order_stops_slice.freezed.dart';

@freezed
abstract class OrderStopsSlice with _$OrderStopsSlice {
  const factory OrderStopsSlice({
    @Default([null, null]) List<OrderLocationEntity?> list,
    @Default(['', '']) List<String> queries,
    @Default([
      BlocStatus<List<OrderSavedLocationEntity>>.initial(),
      BlocStatus<List<OrderSavedLocationEntity>>.initial(),
    ])
    List<BlocStatus<List<OrderSavedLocationEntity>>> suggestionsState,
    @Default(BlocStatus<List<OrderSavedLocationEntity>>.initial())
    BlocStatus<List<OrderSavedLocationEntity>> savedState,
  }) = _OrderStopsSlice;
}
