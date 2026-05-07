import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_model.freezed.dart';
part 'trip_model.g.dart';

@freezed
abstract class TripModel with _$TripModel {
  const factory TripModel({
    required String id,
    required String referenceCode,
    required String status,
    required double quotedFare,
    required String currencyCode,
    required DateTime createdAtUtc,
    DateTime? scheduledAtUtc,
    @Default([]) List<TripStopModel> stops,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);
}

@freezed
abstract class TripStopModel with _$TripStopModel {
  const factory TripStopModel({
    required double latitude,
    required double longitude,
  }) = _TripStopModel;

  factory TripStopModel.fromJson(Map<String, dynamic> json) =>
      _$TripStopModelFromJson(json);
}

@freezed
abstract class TripSummaryModel with _$TripSummaryModel {
  const factory TripSummaryModel({
    required String id,
    required String referenceCode,
    required String status,
    required double quotedFare,
    required String currencyCode,
    required DateTime createdAtUtc,
    DateTime? scheduledAtUtc,
    @Default([]) List<TripStopModel> stops,
  }) = _TripSummaryModel;

  factory TripSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$TripSummaryModelFromJson(json);
}
