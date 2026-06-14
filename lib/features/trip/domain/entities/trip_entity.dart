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
    DateTime? arrivedAtUtc,
    @Default([]) List<TripStopEntity> stops,
    String? vehicleTypeName,
    double? driverLat,
    double? driverLng,
    DateTime? etaToPickup,
    TripCancellationEntity? cancellation,
    TripCompensationClaimEntity? compensationClaim,
    TripWaitingSessionEntity? activeWaitingSession,
    String? encodedOverviewPolyline,
    @Default([]) List<TripRouteSegmentEntity> routeSegments,
    String? passengerNote,
    int? passengerRating,
    String? ratingComment,
  }) = _TripEntity;
}

@freezed
abstract class TripStopEntity with _$TripStopEntity {
  const factory TripStopEntity({
    required double latitude,
    required double longitude,
    String? label,
    @Default(0) int sequence,
    @Default(false) bool isCompleted,
    DateTime? completedAtUtc,
  }) = _TripStopEntity;
}

@freezed
abstract class TripRouteSegmentEntity with _$TripRouteSegmentEntity {
  const factory TripRouteSegmentEntity({
    required int distanceMeters,
    required int durationSeconds,
    required String encodedPolyline,
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) = _TripRouteSegmentEntity;
}

@freezed
abstract class TripCancellationEntity with _$TripCancellationEntity {
  const factory TripCancellationEntity({
    required String actor,
    required String reason,
    required double refundPercent,
    required double refundAmount,
    required String currencyCode,
    String? note,
    DateTime? createdAtUtc,
  }) = _TripCancellationEntity;
}

@freezed
abstract class TripCompensationClaimEntity with _$TripCompensationClaimEntity {
  const factory TripCompensationClaimEntity({
    required String id,
    required String tripId,
    required String passengerId,
    required String note,
    @Default([]) List<String> evidenceUrls,
    required double requestedAmount,
    required String currencyCode,
    required String status,
    String? reviewNotes,
    DateTime? createdAtUtc,
    DateTime? reviewedAtUtc,
  }) = _TripCompensationClaimEntity;
}

@freezed
abstract class TripWaitingSessionEntity with _$TripWaitingSessionEntity {
  const factory TripWaitingSessionEntity({
    required String id,
    required String tripId,
    required String driverId,
    required DateTime startedAtUtc,
    DateTime? stoppedAtUtc,
    int? minutes,
    double? estimatedFee,
    @Default(false) bool isActive,
    @Default(0) double ratePerMinute,
    @Default(10) int graceMinutes,
    int? billableMinutes,
  }) = _TripWaitingSessionEntity;
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
    String? passengerNote,
  }) = _TripSummaryEntity;
}
