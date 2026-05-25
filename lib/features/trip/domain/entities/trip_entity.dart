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
    String? vehicleTypeName,
    double? driverLat,
    double? driverLng,
    DateTime? etaToPickup,
    TripCancellationEntity? cancellation,
    TripCompensationClaimEntity? compensationClaim,
    TripWaitingSessionEntity? activeWaitingSession,
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
  }) = _TripSummaryEntity;
}
