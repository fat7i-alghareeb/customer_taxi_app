import '../../domain/entities/trip_entity.dart';
import '../../domain/entities/trip_status.dart';
import '../models/trip_model.dart';

extension TripModelMapper on TripModel {
  TripEntity get toEntity => TripEntity(
    id: id,
    referenceCode: referenceCode,
    status: TripStatus.fromString(status),
    quotedFare: quotedFare,
    currencyCode: currencyCode,
    createdAtUtc: createdAtUtc,
    scheduledAtUtc: scheduledAtUtc,
    stops: stops.map((s) => s.toStopEntity).toList(),
    vehicleTypeName: vehicleTypeName,
    driverLat: driverLat,
    driverLng: driverLng,
    etaToPickup: etaToPickup,
    cancellation: cancellation?.toEntity,
    compensationClaim: compensationClaim?.toEntity,
    activeWaitingSession: activeWaitingSession?.toEntity,
  );
}

extension TripSummaryModelMapper on TripSummaryModel {
  TripSummaryEntity get toSummaryEntity => TripSummaryEntity(
    id: id,
    referenceCode: referenceCode,
    status: TripStatus.fromString(status),
    quotedFare: quotedFare,
    currencyCode: currencyCode,
    createdAtUtc: createdAtUtc,
    scheduledAtUtc: scheduledAtUtc,
    stops: stops.map((s) => s.toStopEntity).toList(),
  );
}

extension TripStopModelMapper on TripStopModel {
  TripStopEntity get toStopEntity =>
      TripStopEntity(latitude: latitude, longitude: longitude);
}

extension TripCancellationModelMapper on TripCancellationModel {
  TripCancellationEntity get toEntity => TripCancellationEntity(
    actor: actor,
    reason: reason,
    refundPercent: refundPercent,
    refundAmount: refundAmount,
    currencyCode: currencyCode,
    note: note,
    createdAtUtc: createdAtUtc,
  );
}

extension TripCompensationClaimModelMapper on TripCompensationClaimModel {
  TripCompensationClaimEntity get toEntity => TripCompensationClaimEntity(
    id: id,
    tripId: tripId,
    passengerId: passengerId,
    note: note,
    evidenceUrls: evidenceUrls,
    requestedAmount: requestedAmount,
    currencyCode: currencyCode,
    status: status,
    reviewNotes: reviewNotes,
    createdAtUtc: createdAtUtc,
    reviewedAtUtc: reviewedAtUtc,
  );
}

extension TripWaitingSessionModelMapper on TripWaitingSessionModel {
  TripWaitingSessionEntity get toEntity => TripWaitingSessionEntity(
    id: id,
    tripId: tripId,
    driverId: driverId,
    startedAtUtc: startedAtUtc,
    stoppedAtUtc: stoppedAtUtc,
    minutes: minutes,
    estimatedFee: estimatedFee,
    isActive: isActive,
  );
}
