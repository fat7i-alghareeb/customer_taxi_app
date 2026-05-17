import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_sheet_slice.freezed.dart';

enum OrderSheetMode { collapsed, expanded, mapPicking }

enum OrderExpandedStep { locationEntry, carSelection, bookingDetails }

enum OrderLocationTarget { stop }

@freezed
abstract class OrderSheetSlice with _$OrderSheetSlice {
  const factory OrderSheetSlice({
    @Default(OrderSheetMode.collapsed) OrderSheetMode mode,
    @Default(OrderExpandedStep.locationEntry) OrderExpandedStep expandedStep,
    @Default(OrderLocationTarget.stop) OrderLocationTarget mapPickingTarget,
    @Default(0) int activeStopIndex,
  }) = _OrderSheetSlice;
}
