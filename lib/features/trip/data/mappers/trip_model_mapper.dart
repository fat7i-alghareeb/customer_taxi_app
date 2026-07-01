import '../../domain/entities/trip_entity.dart';
import '../../domain/entities/trip_invoice_entity.dart';
import '../../domain/entities/trip_receipt_entity.dart';
import '../../domain/entities/trip_refund_status.dart';
import '../../domain/entities/trip_status.dart';
import '../models/trip_invoice_model.dart';
import '../models/trip_model.dart';
import '../models/trip_receipt_model.dart';

extension TripModelMapper on TripModel {
  TripEntity get toEntity => TripEntity(
    id: id,
    referenceCode: referenceCode,
    status: TripStatus.fromString(status),
    quotedFare: quotedFare,
    currencyCode: currencyCode,
    createdAtUtc: createdAtUtc,
    scheduledAtUtc: scheduledAtUtc,
    arrivedAtUtc: arrivedAtUtc,
    stops: stops.map((s) => s.toStopEntity).toList(),
    vehicleTypeName: vehicleTypeName,
    driverLat: driverLat,
    driverLng: driverLng,
    etaToPickup: etaToPickup,
    cancellation: cancellation?.toEntity,
    refund: refund?.toEntity,
    compensationClaim: compensationClaim?.toEntity,
    activeWaitingSession: activeWaitingSession?.toEntity,
    encodedOverviewPolyline: encodedOverviewPolyline,
    routeSegments: routeSegments.map((s) => s.toEntity).toList(),
    passengerNote: passengerNote,
    passengerRating: passengerRating,
    ratingComment: ratingComment,
    acceptedByAdminId: acceptedByAdminId,
    acceptedAdminName: acceptedAdminName,
    acceptedAtUtc: acceptedAtUtc,
    isScheduled: isScheduled,
    dispatchWindowOpensAtUtc: dispatchWindowOpensAtUtc,
    canMarkEnRoute: canMarkEnRoute,
    attentionState: attentionState,
  );
}

extension TripRouteSegmentModelMapper on TripRouteSegmentModel {
  TripRouteSegmentEntity get toEntity => TripRouteSegmentEntity(
    distanceMeters: distanceMeters,
    durationSeconds: durationSeconds,
    encodedPolyline: encodedPolyline,
    startLatitude: startLatitude,
    startLongitude: startLongitude,
    endLatitude: endLatitude,
    endLongitude: endLongitude,
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
    passengerNote: passengerNote,
  );
}

extension TripStopModelMapper on TripStopModel {
  TripStopEntity get toStopEntity => TripStopEntity(
    latitude: latitude,
    longitude: longitude,
    label: label,
    sequence: sequence,
    isCompleted: isCompleted,
    completedAtUtc: completedAtUtc,
  );
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

extension TripRefundModelMapper on TripRefundModel {
  TripRefundEntity get toEntity => TripRefundEntity(
    status: TripRefundStatus.fromString(status),
    amount: amount,
    currencyCode: currencyCode,
    completedAtUtc: completedAtUtc,
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
    ratePerMinute: ratePerMinute,
    graceMinutes: graceMinutes,
    billableMinutes: billableMinutes,
  );
}

extension TripReceiptModelMapper on TripReceiptModel {
  TripReceiptEntity get toEntity => TripReceiptEntity(
    tripId: tripId,
    referenceCode: referenceCode,
    status: status,
    grossAmount: grossAmount,
    netAmount: netAmount,
    taxAmount: taxAmount,
    currencyCode: currencyCode,
    paymentMethod: paymentMethod,
    paymentReference: paymentReference,
    paidAtUtc: paidAtUtc,
    completedAtUtc: completedAtUtc,
    distanceKm: distanceKm,
    durationMin: durationMin,
    vehicleTypeName: vehicleTypeName,
    passengerName: passengerName,
    issuerName: issuerName,
    invoiceAvailable: invoiceAvailable,
    invoiceNumber: invoiceNumber,
    invoiceIssuedAtUtc: invoiceIssuedAtUtc,
    stops: stops.map((s) => s.toStopEntity).toList(),
  );
}

extension TripInvoiceModelMapper on TripInvoiceModel {
  TripInvoiceEntity get toEntity => TripInvoiceEntity(
    invoiceId: invoiceId,
    tripId: tripId,
    invoiceNumber: invoiceNumber,
    issuedAtUtc: issuedAtUtc,
    currencyCode: currencyCode,
    grossAmount: grossAmount,
    netAmount: netAmount,
    taxRate: taxRate,
    taxAmount: taxAmount,
    paymentMethod: paymentMethod,
    paymentReference: paymentReference,
    paidAtUtc: paidAtUtc,
    issuerName: issuerName,
    issuerAddress: issuerAddress,
    issuerVatNumber: issuerVatNumber,
    tripReferenceCode: tripReferenceCode,
    tripCompletedAtUtc: tripCompletedAtUtc,
    distanceKm: distanceKm,
    durationMin: durationMin,
    vehicleTypeName: vehicleTypeName,
    passengerName: passengerName,
    stops: stops.map((s) => s.toEntity).toList(),
  );
}

extension TripInvoiceStopModelMapper on TripInvoiceStopModel {
  TripInvoiceStopEntity get toEntity => TripInvoiceStopEntity(
    sequence: sequence,
    label: label,
    completedAtUtc: completedAtUtc,
  );
}
