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
    TripRefundIssueEntity? refundIssue,
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

  /// Whether the customer edit window is still open. Mirrors the server rule
  /// (`TripEditPolicy.IsWithinCustomerEditWindow`) so the edit affordances
  /// disappear exactly when the server would refuse, instead of leaving a
  /// pencil that fails on tap.
  ///
  /// The window closes exactly 5 minutes after booking, for every trip type.
  /// A scheduled pickup does *not* extend it: a ride booked for next week locks
  /// at the same 5-minute mark as an immediate one, so the rider only ever has
  /// one deadline to understand.
  bool get _isWithinCustomerEditWindow =>
      !DateTime.now().toUtc().isAfter(customerEditDeadlineUtc);

  /// The instant every edit affordance turns off. Exposed so the sheet can set a
  /// timer for it — nothing else rebuilds on the clock, so without that the
  /// pencils would stay lit past the deadline until the next poll.
  DateTime get customerEditDeadlineUtc =>
      createdAtUtc.toUtc().add(const Duration(minutes: 5));

  /// Whether the rider may still repoint any stop.
  bool get canEditStops =>
      status.isEditableForRepricing && _isWithinCustomerEditWindow;

  /// Whether the rider may still change the passenger or bag count.
  bool get canEditPartySize =>
      status.isPartySizeEditable && _isWithinCustomerEditWindow;

  /// Whether the rider may still move the scheduled pickup time. Mirrors
  /// `TripEditPolicy.CanEditSchedule` — same status gate as the party size, and
  /// the same 5-minute window as everything else. This used to be a separate
  /// 1-hour rule on both sides.
  bool get canEditSchedule =>
      status.isPartySizeEditable && _isWithinCustomerEditWindow;

  /// The instant this trip stops being a quiet reservation and starts being a
  /// ride in progress. Mirrors the server's
  /// `Trip.DispatchWindowOpensAtUtc` = `ScheduledAtUtc - ScheduledEnRouteLeadTime`,
  /// falling back to the same 15-minute lead if the server did not send it.
  DateTime? get reservationWindowOpensAtUtc {
    final scheduled = scheduledAtUtc;
    if (scheduled == null) return null;
    return (dispatchWindowOpensAtUtc ??
            scheduled.subtract(const Duration(minutes: 15)))
        .toUtc();
  }

  /// A scheduled trip whose dispatch window has not opened yet.
  ///
  /// These do NOT take over the Home tab: the passenger may hold any number of
  /// future reservations and still book another ride. Note the rule is purely
  /// time-based — an admin accepting a trip days ahead (which is routine, and
  /// what the accepted-reminder stages exist for) must not hijack the map.
  bool get isReservedFuture {
    if (status.isTerminal) return false;
    final opensAt = reservationWindowOpensAtUtc;
    if (opensAt == null) return false;
    if (status == TripStatus.enRoute ||
        status == TripStatus.arrived ||
        status == TripStatus.inProgress) {
      return false;
    }
    return DateTime.now().toUtc().isBefore(opensAt);
  }

  /// A trip that owns the Home tab right now: any non-terminal trip that is not
  /// a future reservation. At most one of these exists at a time.
  bool get isLiveNow => !status.isTerminal && !isReservedFuture;
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

    /// Flat fee withheld from the fare ("annuleringskosten"), 0 when none applied.
    /// Non-zero only for a passenger cancellation inside the 5-minute window, where
    /// [refundPercent] stays 100 and the deduction lives here instead.
    @Default(0) double cancellationFeeAmount,
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

/// The passenger's most recent refund review request for this trip.
///
/// [isOpen] is computed by the server (`TripRefundIssueDto.IsOpen`) rather than
/// derived from [status] here, so the rule about which statuses still block a
/// new request lives in one place. While it is true the app shows the "under
/// review" panel instead of the submit form; once an admin resolves or dismisses
/// the request the slot frees and the form comes back.
@freezed
abstract class TripRefundIssueEntity with _$TripRefundIssueEntity {
  const factory TripRefundIssueEntity({
    required String id,
    required String requestType,
    required String status,
    required bool isOpen,
    required DateTime createdAtUtc,
    DateTime? reviewedAtUtc,
  }) = _TripRefundIssueEntity;
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
