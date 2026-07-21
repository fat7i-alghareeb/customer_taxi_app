import 'package:freezed_annotation/freezed_annotation.dart';
import 'trip_refund_status.dart';
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
    TripRefundEntity? refund,
    TripCompensationClaimEntity? compensationClaim,
    TripWaitingSessionEntity? activeWaitingSession,
    String? encodedOverviewPolyline,
    @Default([]) List<TripRouteSegmentEntity> routeSegments,
    String? passengerNote,
    int? passengerRating,
    String? ratingComment,
    String? acceptedByAdminId,
    String? acceptedAdminName,
    DateTime? acceptedAtUtc,
    @Default(false) bool isScheduled,
    DateTime? dispatchWindowOpensAtUtc,
    @Default(false) bool canMarkEnRoute,
    @Default('Normal') String attentionState,
    @Default(1) int passengerCount,
    @Default(0) int bagCount,
    @Default(false) bool noDriverDecisionRequired,
  }) = _TripEntity;

  const TripEntity._();

  /// Whether the rider may still repoint any stop. Mirrors the server rule so
  /// the edit affordance disappears exactly when the server would refuse,
  /// instead of leaving a pencil that fails on tap.
  ///
  /// The window closes an hour after booking, or — for a scheduled ride — an
  /// hour before pickup, whichever is later. Anchoring on the pickup keeps the
  /// address correctable for a ride booked days ahead; taking the later of the
  /// two preserves the full booking hour for a ride scheduled very soon.
  bool get canEditStops {
    if (!status.isEditableForRepricing) return false;

    final bookingDeadline = createdAtUtc.add(const Duration(hours: 1));
    final scheduled = scheduledAtUtc;
    final deadline = scheduled == null
        ? bookingDeadline
        : _laterOf(
            scheduled.subtract(const Duration(hours: 1)),
            bookingDeadline,
          );

    return !DateTime.now().toUtc().isAfter(deadline.toUtc());
  }

  /// Whether the rider may still change the passenger or bag count.
  bool get canEditPartySize => status.isPartySizeEditable;

  static DateTime _laterOf(DateTime a, DateTime b) => a.isAfter(b) ? a : b;
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
abstract class TripRefundEntity with _$TripRefundEntity {
  const factory TripRefundEntity({
    required TripRefundStatus status,
    required double amount,
    required String currencyCode,
    DateTime? completedAtUtc,
  }) = _TripRefundEntity;
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
