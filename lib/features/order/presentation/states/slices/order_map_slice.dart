import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customertaxi/utils/constants/app_flow_constants.dart';

part 'order_map_slice.freezed.dart';

@freezed
abstract class OrderMapSlice with _$OrderMapSlice {
  const factory OrderMapSlice({
    @Default(MapConfig.defaultLat) double latitude,
    @Default(MapConfig.defaultLng) double longitude,
    @Default(MapConfig.initialZoom) double zoom,
  }) = _OrderMapSlice;
}
