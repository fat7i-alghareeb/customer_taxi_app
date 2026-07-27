import 'package:flutter_test/flutter_test.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/states/reservation_confirmation_cubit.dart';

const _tripId = 'trip-1';

TripEntity _trip({
  required TripStatus status,
  DateTime? scheduledAtUtc,
  DateTime? dispatchWindowOpensAtUtc,
  String id = _tripId,
}) {
  return TripEntity(
    id: id,
    referenceCode: 'OT-0001',
    status: status,
    quotedFare: 25,
    currencyCode: 'EUR',
    createdAtUtc: DateTime.now().toUtc(),
    scheduledAtUtc: scheduledAtUtc,
    dispatchWindowOpensAtUtc: dispatchWindowOpensAtUtc,
    isScheduled: scheduledAtUtc != null,
  );
}

ActiveTripState _state(
  List<TripEntity> trips, {
  bool loaded = true,
  bool loading = false,
}) {
  return ActiveTripState(trips: trips, loaded: loaded, loading: loading);
}

ReservationOverlayVerdict _verdict(
  ActiveTripState state, {
  bool seenAsReserved = false,
}) {
  return resolveReservationOverlay(
    tripId: _tripId,
    state: state,
    seenAsReserved: seenAsReserved,
  );
}

void main() {
  final now = DateTime.now().toUtc();

  test('a still-future reservation keeps the overlay and marks it seen', () {
    final trip = _trip(
      status: TripStatus.awaitingAdminAcceptance,
      scheduledAtUtc: now.add(const Duration(hours: 2)),
      dispatchWindowOpensAtUtc: now.add(const Duration(hours: 1, minutes: 45)),
    );

    expect(
      _verdict(_state([trip])),
      ReservationOverlayVerdict.keepAndMarkSeen,
    );
  });

  test('a ride accepted a week early still keeps the overlay', () {
    // The case that must NOT close it: an admin taking a scheduled trip days
    // ahead is routine and means nothing has started yet.
    final trip = _trip(
      status: TripStatus.accepted,
      scheduledAtUtc: now.add(const Duration(days: 7)),
      dispatchWindowOpensAtUtc: now.add(
        const Duration(days: 6, hours: 23, minutes: 45),
      ),
    );

    expect(
      _verdict(_state([trip])),
      ReservationOverlayVerdict.keepAndMarkSeen,
    );
  });

  for (final status in [
    TripStatus.enRoute,
    TripStatus.arrived,
    TripStatus.inProgress,
  ]) {
    test('a scheduled trip in ${status.name} dismisses the overlay', () {
      // Pickup is still an hour out, so only the status makes it live.
      final trip = _trip(
        status: status,
        scheduledAtUtc: now.add(const Duration(hours: 1)),
        dispatchWindowOpensAtUtc: now.add(const Duration(minutes: 45)),
      );

      expect(
        _verdict(_state([trip]), seenAsReserved: true),
        ReservationOverlayVerdict.dismiss,
      );
    });
  }

  test('an opened dispatch window dismisses the overlay', () {
    // Booked ~16 minutes out: the window opens a minute later, while the
    // overlay is still on screen.
    final trip = _trip(
      status: TripStatus.awaitingAdminAcceptance,
      scheduledAtUtc: now.add(const Duration(minutes: 14)),
      dispatchWindowOpensAtUtc: now.subtract(const Duration(minutes: 1)),
    );

    expect(
      _verdict(_state([trip]), seenAsReserved: true),
      ReservationOverlayVerdict.dismiss,
    );
  });

  test('an immediate trip is never a reservation and dismisses', () {
    final trip = _trip(status: TripStatus.awaitingAdminAcceptance);

    expect(_verdict(_state([trip])), ReservationOverlayVerdict.dismiss);
  });

  test('absent and never seen while loading keeps the overlay', () {
    // The post-booking race: a refresh already in flight can resolve without
    // the new trip in it. Dismissing here would flash the overlay away the
    // instant it appeared.
    expect(
      _verdict(_state(const [], loading: true)),
      ReservationOverlayVerdict.keep,
    );
  });

  test('absent and never seen, settled, still keeps the overlay', () {
    expect(_verdict(_state(const [])), ReservationOverlayVerdict.keep);
  });

  test('absent after being seen dismisses the overlay', () {
    // The trip was cancelled out from under the confirmation.
    expect(
      _verdict(_state(const []), seenAsReserved: true),
      ReservationOverlayVerdict.dismiss,
    );
  });

  test('absent after being seen but mid-refresh waits', () {
    expect(
      _verdict(_state(const [], loading: true), seenAsReserved: true),
      ReservationOverlayVerdict.keep,
    );
  });

  test('another passenger trip going live leaves this overlay alone', () {
    final other = _trip(status: TripStatus.inProgress, id: 'trip-2');
    final mine = _trip(
      status: TripStatus.awaitingAdminAcceptance,
      scheduledAtUtc: now.add(const Duration(hours: 3)),
      dispatchWindowOpensAtUtc: now.add(const Duration(hours: 2, minutes: 45)),
    );

    expect(
      _verdict(_state([other, mine])),
      ReservationOverlayVerdict.keepAndMarkSeen,
    );
  });
}
