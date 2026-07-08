// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripModel _$TripModelFromJson(Map<String, dynamic> json) => _TripModel(
  id: json['id'] as String,
  referenceCode: json['referenceCode'] as String,
  status: json['status'] as String,
  quotedFare: (json['quotedFare'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
  scheduledAtUtc: json['scheduledAtUtc'] == null
      ? null
      : DateTime.parse(json['scheduledAtUtc'] as String),
  arrivedAtUtc: json['arrivedAtUtc'] == null
      ? null
      : DateTime.parse(json['arrivedAtUtc'] as String),
  stops:
      (json['stops'] as List<dynamic>?)
          ?.map((e) => TripStopModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  vehicleTypeName: json['vehicleTypeName'] as String?,
  driverLat: (json['driverLat'] as num?)?.toDouble(),
  driverLng: (json['driverLng'] as num?)?.toDouble(),
  etaToPickup: json['etaToPickup'] == null
      ? null
      : DateTime.parse(json['etaToPickup'] as String),
  cancellation: json['cancellation'] == null
      ? null
      : TripCancellationModel.fromJson(
          json['cancellation'] as Map<String, dynamic>,
        ),
  refund: json['refund'] == null
      ? null
      : TripRefundModel.fromJson(json['refund'] as Map<String, dynamic>),
  compensationClaim: json['compensationClaim'] == null
      ? null
      : TripCompensationClaimModel.fromJson(
          json['compensationClaim'] as Map<String, dynamic>,
        ),
  activeWaitingSession: json['activeWaitingSession'] == null
      ? null
      : TripWaitingSessionModel.fromJson(
          json['activeWaitingSession'] as Map<String, dynamic>,
        ),
  encodedOverviewPolyline: json['encodedOverviewPolyline'] as String?,
  routeSegments:
      (json['routeSegments'] as List<dynamic>?)
          ?.map(
            (e) => TripRouteSegmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  passengerNote: json['passengerNote'] as String?,
  passengerRating: (json['passengerRating'] as num?)?.toInt(),
  ratingComment: json['ratingComment'] as String?,
  acceptedByAdminId: json['acceptedByAdminId'] as String?,
  acceptedAdminName: json['acceptedAdminName'] as String?,
  acceptedAtUtc: json['acceptedAtUtc'] == null
      ? null
      : DateTime.parse(json['acceptedAtUtc'] as String),
  isScheduled: json['isScheduled'] as bool? ?? false,
  dispatchWindowOpensAtUtc: json['dispatchWindowOpensAtUtc'] == null
      ? null
      : DateTime.parse(json['dispatchWindowOpensAtUtc'] as String),
  canMarkEnRoute: json['canMarkEnRoute'] as bool? ?? false,
  attentionState: json['attentionState'] as String? ?? 'Normal',
  passengerCount: (json['passengerCount'] as num?)?.toInt() ?? 1,
  bagCount: (json['bagCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TripModelToJson(_TripModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'referenceCode': instance.referenceCode,
      'status': instance.status,
      'quotedFare': instance.quotedFare,
      'currencyCode': instance.currencyCode,
      'createdAtUtc': instance.createdAtUtc.toIso8601String(),
      'scheduledAtUtc': instance.scheduledAtUtc?.toIso8601String(),
      'arrivedAtUtc': instance.arrivedAtUtc?.toIso8601String(),
      'stops': instance.stops,
      'vehicleTypeName': instance.vehicleTypeName,
      'driverLat': instance.driverLat,
      'driverLng': instance.driverLng,
      'etaToPickup': instance.etaToPickup?.toIso8601String(),
      'cancellation': instance.cancellation,
      'refund': instance.refund,
      'compensationClaim': instance.compensationClaim,
      'activeWaitingSession': instance.activeWaitingSession,
      'encodedOverviewPolyline': instance.encodedOverviewPolyline,
      'routeSegments': instance.routeSegments,
      'passengerNote': instance.passengerNote,
      'passengerRating': instance.passengerRating,
      'ratingComment': instance.ratingComment,
      'acceptedByAdminId': instance.acceptedByAdminId,
      'acceptedAdminName': instance.acceptedAdminName,
      'acceptedAtUtc': instance.acceptedAtUtc?.toIso8601String(),
      'isScheduled': instance.isScheduled,
      'dispatchWindowOpensAtUtc': instance.dispatchWindowOpensAtUtc
          ?.toIso8601String(),
      'canMarkEnRoute': instance.canMarkEnRoute,
      'attentionState': instance.attentionState,
      'passengerCount': instance.passengerCount,
      'bagCount': instance.bagCount,
    };

_TripRouteSegmentModel _$TripRouteSegmentModelFromJson(
  Map<String, dynamic> json,
) => _TripRouteSegmentModel(
  distanceMeters: (json['distanceMeters'] as num).toInt(),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  encodedPolyline: json['encodedPolyline'] as String,
  startLatitude: (json['startLatitude'] as num).toDouble(),
  startLongitude: (json['startLongitude'] as num).toDouble(),
  endLatitude: (json['endLatitude'] as num).toDouble(),
  endLongitude: (json['endLongitude'] as num).toDouble(),
);

Map<String, dynamic> _$TripRouteSegmentModelToJson(
  _TripRouteSegmentModel instance,
) => <String, dynamic>{
  'distanceMeters': instance.distanceMeters,
  'durationSeconds': instance.durationSeconds,
  'encodedPolyline': instance.encodedPolyline,
  'startLatitude': instance.startLatitude,
  'startLongitude': instance.startLongitude,
  'endLatitude': instance.endLatitude,
  'endLongitude': instance.endLongitude,
};

_TripStopModel _$TripStopModelFromJson(Map<String, dynamic> json) =>
    _TripStopModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      label: json['label'] as String?,
      sequence: (json['sequence'] as num?)?.toInt() ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAtUtc: json['completedAtUtc'] == null
          ? null
          : DateTime.parse(json['completedAtUtc'] as String),
    );

Map<String, dynamic> _$TripStopModelToJson(_TripStopModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'label': instance.label,
      'sequence': instance.sequence,
      'isCompleted': instance.isCompleted,
      'completedAtUtc': instance.completedAtUtc?.toIso8601String(),
    };

_TripCancellationModel _$TripCancellationModelFromJson(
  Map<String, dynamic> json,
) => _TripCancellationModel(
  actor: json['actor'] as String,
  reason: json['reason'] as String,
  refundPercent: (json['refundPercent'] as num).toDouble(),
  refundAmount: (json['refundAmount'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  note: json['note'] as String?,
  createdAtUtc: json['createdAtUtc'] == null
      ? null
      : DateTime.parse(json['createdAtUtc'] as String),
);

Map<String, dynamic> _$TripCancellationModelToJson(
  _TripCancellationModel instance,
) => <String, dynamic>{
  'actor': instance.actor,
  'reason': instance.reason,
  'refundPercent': instance.refundPercent,
  'refundAmount': instance.refundAmount,
  'currencyCode': instance.currencyCode,
  'note': instance.note,
  'createdAtUtc': instance.createdAtUtc?.toIso8601String(),
};

_TripRefundModel _$TripRefundModelFromJson(Map<String, dynamic> json) =>
    _TripRefundModel(
      status: json['status'] as String,
      amount: (json['amount'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
      completedAtUtc: json['completedAtUtc'] == null
          ? null
          : DateTime.parse(json['completedAtUtc'] as String),
    );

Map<String, dynamic> _$TripRefundModelToJson(_TripRefundModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'amount': instance.amount,
      'currencyCode': instance.currencyCode,
      'completedAtUtc': instance.completedAtUtc?.toIso8601String(),
    };

_TripCompensationClaimModel _$TripCompensationClaimModelFromJson(
  Map<String, dynamic> json,
) => _TripCompensationClaimModel(
  id: json['id'] as String,
  tripId: json['tripId'] as String,
  passengerId: json['passengerId'] as String,
  note: json['note'] as String,
  evidenceUrls:
      (json['evidenceUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  requestedAmount: (json['requestedAmount'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  status: json['status'] as String,
  reviewNotes: json['reviewNotes'] as String?,
  createdAtUtc: json['createdAtUtc'] == null
      ? null
      : DateTime.parse(json['createdAtUtc'] as String),
  reviewedAtUtc: json['reviewedAtUtc'] == null
      ? null
      : DateTime.parse(json['reviewedAtUtc'] as String),
);

Map<String, dynamic> _$TripCompensationClaimModelToJson(
  _TripCompensationClaimModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'tripId': instance.tripId,
  'passengerId': instance.passengerId,
  'note': instance.note,
  'evidenceUrls': instance.evidenceUrls,
  'requestedAmount': instance.requestedAmount,
  'currencyCode': instance.currencyCode,
  'status': instance.status,
  'reviewNotes': instance.reviewNotes,
  'createdAtUtc': instance.createdAtUtc?.toIso8601String(),
  'reviewedAtUtc': instance.reviewedAtUtc?.toIso8601String(),
};

_TripWaitingSessionModel _$TripWaitingSessionModelFromJson(
  Map<String, dynamic> json,
) => _TripWaitingSessionModel(
  id: json['id'] as String,
  tripId: json['tripId'] as String,
  driverId: json['driverId'] as String,
  startedAtUtc: DateTime.parse(json['startedAtUtc'] as String),
  stoppedAtUtc: json['stoppedAtUtc'] == null
      ? null
      : DateTime.parse(json['stoppedAtUtc'] as String),
  minutes: (json['minutes'] as num?)?.toInt(),
  estimatedFee: (json['estimatedFee'] as num?)?.toDouble(),
  isActive: json['isActive'] as bool? ?? false,
  ratePerMinute: (json['ratePerMinute'] as num?)?.toDouble() ?? 0,
  graceMinutes: (json['graceMinutes'] as num?)?.toInt() ?? 10,
  billableMinutes: (json['billableMinutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$TripWaitingSessionModelToJson(
  _TripWaitingSessionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'tripId': instance.tripId,
  'driverId': instance.driverId,
  'startedAtUtc': instance.startedAtUtc.toIso8601String(),
  'stoppedAtUtc': instance.stoppedAtUtc?.toIso8601String(),
  'minutes': instance.minutes,
  'estimatedFee': instance.estimatedFee,
  'isActive': instance.isActive,
  'ratePerMinute': instance.ratePerMinute,
  'graceMinutes': instance.graceMinutes,
  'billableMinutes': instance.billableMinutes,
};

_TripSummaryModel _$TripSummaryModelFromJson(Map<String, dynamic> json) =>
    _TripSummaryModel(
      id: json['id'] as String,
      referenceCode: json['referenceCode'] as String,
      status: json['status'] as String,
      quotedFare: (json['quotedFare'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
      createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
      scheduledAtUtc: json['scheduledAtUtc'] == null
          ? null
          : DateTime.parse(json['scheduledAtUtc'] as String),
      stops:
          (json['stops'] as List<dynamic>?)
              ?.map((e) => TripStopModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      passengerNote: json['passengerNote'] as String?,
    );

Map<String, dynamic> _$TripSummaryModelToJson(_TripSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'referenceCode': instance.referenceCode,
      'status': instance.status,
      'quotedFare': instance.quotedFare,
      'currencyCode': instance.currencyCode,
      'createdAtUtc': instance.createdAtUtc.toIso8601String(),
      'scheduledAtUtc': instance.scheduledAtUtc?.toIso8601String(),
      'stops': instance.stops,
      'passengerNote': instance.passengerNote,
    };
