import 'package:freezed_annotation/freezed_annotation.dart';
import 'trip_status.dart';

part 'trip_entity.freezed.dart';

@freezed
abstract class TripEntity with _$TripEntity {
  const factory TripEntity({
    required String id,
    required String referenceCode,
    required TripStatus status,
    required double quotedFare,
    required String currencyCode,
    required DateTime createdAtUtc,
    DateTime? scheduledAtUtc,
    @Default([]) List<TripStopEntity> stops,
  }) = _TripEntity;
}

@freezed
abstract class TripStopEntity with _$TripStopEntity {
  const factory TripStopEntity({
    required double latitude,
    required double longitude,
  }) = _TripStopEntity;
}

@freezed
abstract class TripSummaryEntity with _$TripSummaryEntity {
  const factory TripSummaryEntity({
    required String id,
    required String referenceCode,
    required TripStatus status,
    required double quotedFare,
    required String currencyCode,
    required DateTime createdAtUtc,
    DateTime? scheduledAtUtc,
    @Default([]) List<TripStopEntity> stops,
  }) = _TripSummaryEntity;
}
