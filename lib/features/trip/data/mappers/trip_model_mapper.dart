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
