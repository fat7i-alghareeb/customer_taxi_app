import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../core/router/router_config.dart';
import '../../../../core/injection/injectable.dart';
import '../../../../core/services/realtime/realtime_event.dart';
import '../../../../core/services/realtime/realtime_service.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../../root/presentation/ui/screens/root_screen.dart';
import '../../domain/entities/trip_status.dart';
import '../../domain/facade/trip_facade.dart';
import '../states/active_trip_cubit.dart';
import '../ui/widgets/trip_rating_sheet.dart';

/// App-level coordinator that opens the post-trip rating sheet the moment a
/// trip becomes `Completed`, regardless of which screen the user is on.
///
/// It listens to [RealtimeService.events] for [RealtimeTripCompleted] (the
/// backend dual-sends completion to the passenger's always-on `User_{id}`
/// group, so this fires even if the active-trip screen never joined the trip
/// group). It can also be driven by the `trip_completed` FCM push tap via
/// [promptRatingForTrip] for the app-was-closed case.
///
/// A per-trip de-dupe set guarantees the sheet is shown at most once per trip,
/// even when both the SignalR event and the push tap arrive.
@lazySingleton
class TripCompletionCoordinator {
  TripCompletionCoordinator(this._realtime, this._router, this._facade);

  static const String _logTag = '[TripCompletion]';

  final RealtimeService _realtime;
  final AppRouterConfig _router;
  final TripFacade _facade;

  StreamSubscription<RealtimeEvent>? _sub;
  final Set<String> _prompted = <String>{};
  bool _started = false;

  /// Subscribes to realtime completion events. Idempotent.
  void start() {
    if (_started) return;
    _started = true;
    printC('$_logTag start — listening for TripCompleted');
    _sub = _realtime.events.listen((event) {
      if (event is RealtimeTripCompleted) {
        printG('$_logTag realtime TripCompleted trip=${event.tripId}');
        unawaited(promptRatingForCompletedTrip(event.tripId));
      }
    });
  }

  Future<void> stop() async {
    _started = false;
    await _sub?.cancel();
    _sub = null;
  }

  /// Back-compat entry used by the `trip_completed` FCM push tap. Verifies the
  /// trip is completed and unrated before showing the sheet.
  Future<void> promptRatingForTrip(String tripId) =>
      promptRatingForCompletedTrip(tripId);

  /// Loads [tripId] and shows the rating sheet only when it is **completed** and
  /// **not yet rated**. De-duped per trip across the realtime, push and
  /// active-trip-ended entry points. Cancelled trips never trigger a rating.
  Future<void> promptRatingForCompletedTrip(String tripId) async {
    if (tripId.isEmpty || _prompted.contains(tripId)) {
      return;
    }

    final result = await _facade.getTripById(tripId);
    await result.when(
      success: (trip) async {
        if (trip.status != TripStatus.completed) {
          printM('$_logTag trip not completed yet — skip trip=$tripId');
          return;
        }
        if (trip.passengerRating != null) {
          printM('$_logTag trip already rated — skip trip=$tripId');
          _prompted.add(tripId);
          return;
        }
        await _showRatingSheet(tripId);
      },
      failure: (msg) async {
        printY('$_logTag load trip failed trip=$tripId: $msg');
      },
    );
  }

  /// Navigates to the root screen and shows the rating sheet. De-duped.
  Future<void> _showRatingSheet(String tripId) async {
    if (!_prompted.add(tripId)) {
      return;
    }

    printC('$_logTag navigating to root then showing rating trip=$tripId');
    _router.router.go(RootScreen.pagePath);

    final context = _router.router.routerDelegate.navigatorKey.currentContext;
    if (context == null || !context.mounted) {
      printY('$_logTag no navigator context — cannot show rating trip=$tripId');
      _prompted.remove(tripId); // allow a retry from another entry point
      return;
    }

    await showTripRatingSheet(
      context,
      tripId: tripId,
      onClosed: () => getIt<ActiveTripCubit>().refresh(),
    );
    printG('$_logTag rating sheet closed trip=$tripId');
  }
}
