import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_trip_stop_model.freezed.dart';
part 'order_trip_stop_model.g.dart';

@freezed
abstract class OrderTripStopModel with _$OrderTripStopModel {
  const factory OrderTripStopModel({
    required double latitude,
    required double longitude,
  }) = _OrderTripStopModel;

  factory OrderTripStopModel.fromJson(Map<String, dynamic> json) =>
      _$OrderTripStopModelFromJson(json);
}
