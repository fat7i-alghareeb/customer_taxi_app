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
    DateTime? arrivedAtUtc,
    @Default([]) List<TripStopModel> stops,
    String? vehicleTypeName,
    double? driverLat,
    double? driverLng,
    DateTime? etaToPickup,
    TripCancellationModel? cancellation,
    TripRefundModel? refund,
    TripRefundIssueModel? refundIssue,
    TripCompensationClaimModel? compensationClaim,
    TripWaitingSessionModel? activeWaitingSession,
    String? encodedOverviewPolyline,
    @Default([]) List<TripRouteSegmentModel> routeSegments,
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
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);
}

@freezed
abstract class TripRouteSegmentModel with _$TripRouteSegmentModel {
  const factory TripRouteSegmentModel({
    required int distanceMeters,
    required int durationSeconds,
    required String encodedPolyline,
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) = _TripRouteSegmentModel;

  factory TripRouteSegmentModel.fromJson(Map<String, dynamic> json) =>
      _$TripRouteSegmentModelFromJson(json);
}

@freezed
abstract class TripStopModel with _$TripStopModel {
  const factory TripStopModel({
    required double latitude,
    required double longitude,
    String? label,
    @Default(0) int sequence,
    @Default(false) bool isCompleted,
    DateTime? completedAtUtc,
  }) = _TripStopModel;

  factory TripStopModel.fromJson(Map<String, dynamic> json) =>
      _$TripStopModelFromJson(json);
}

@freezed
abstract class TripCancellationModel with _$TripCancellationModel {
  const factory TripCancellationModel({
    required String actor,
    required String reason,
    required double refundPercent,
    required double refundAmount,
    required String currencyCode,
    /// Flat fee withheld from the fare. Defaulted for older payloads that predate the field.
    @Default(0) double cancellationFeeAmount,
    String? note,
    DateTime? createdAtUtc,
  }) = _TripCancellationModel;

  factory TripCancellationModel.fromJson(Map<String, dynamic> json) =>
      _$TripCancellationModelFromJson(json);
}

@freezed
abstract class TripRefundModel with _$TripRefundModel {
  const factory TripRefundModel({
    required String status,
    required double amount,
    required String currencyCode,
    DateTime? completedAtUtc,
  }) = _TripRefundModel;

  factory TripRefundModel.fromJson(Map<String, dynamic> json) =>
      _$TripRefundModelFromJson(json);
}

/// The passenger's most recent refund review request for this trip, so the app
/// can show "under review" instead of offering the form a second time. `isOpen`
/// is computed server-side so the rule about which statuses still block a new
/// request lives in one place.
@freezed
abstract class TripRefundIssueModel with _$TripRefundIssueModel {
  const factory TripRefundIssueModel({
    required String id,
    required String requestType,
    required String status,
    required bool isOpen,
    required DateTime createdAtUtc,
    DateTime? reviewedAtUtc,
  }) = _TripRefundIssueModel;

  factory TripRefundIssueModel.fromJson(Map<String, dynamic> json) =>
      _$TripRefundIssueModelFromJson(json);
}

@freezed
abstract class TripCompensationClaimModel with _$TripCompensationClaimModel {
  const factory TripCompensationClaimModel({
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
  }) = _TripCompensationClaimModel;

  factory TripCompensationClaimModel.fromJson(Map<String, dynamic> json) =>
      _$TripCompensationClaimModelFromJson(json);
}

@freezed
abstract class TripWaitingSessionModel with _$TripWaitingSessionModel {
  const factory TripWaitingSessionModel({
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
  }) = _TripWaitingSessionModel;

  factory TripWaitingSessionModel.fromJson(Map<String, dynamic> json) =>
      _$TripWaitingSessionModelFromJson(json);
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
    String? passengerNote,
  }) = _TripSummaryModel;

  factory TripSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$TripSummaryModelFromJson(json);
}
