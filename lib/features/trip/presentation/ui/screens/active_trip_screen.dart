import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/router/safe_pop.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/root_screen.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/root_body.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import '../widgets/active_trip_body.dart';

/// Standalone view of a single trip, pushed when the rider taps a *future
/// reservation* in the Trips tab or the reserved-trips banner on the map.
///
/// A ride already underway is never opened here — `TripCard` sends those to the
/// Home tab instead, where `ActiveTripGate` renders the same body with the
/// bottom bar still reachable. This screen therefore carries a close button:
/// without one it is a dead end on iOS, which has no system back button and no
/// edge-swipe either (routes are built with `CustomTransitionPage`).
///
/// The moment the reservation turns into a live trip the button disappears and
/// the screen hands over to the Home tab — an active trip must not be
/// backed out of.
class ActiveTripScreen extends StatefulWidget {
  const ActiveTripScreen({super.key});

  static const String pagePath = '/active_trip';
  static const String pageName = 'ActiveTripScreen';

  @override
  State<ActiveTripScreen> createState() => _ActiveTripScreenState();
}

class _ActiveTripScreenState extends State<ActiveTripScreen> {
  /// Fires at the exact instant the reservation's dispatch window opens.
  ///
  /// Both `ActiveTripCubit`'s partition ticker and `TripBloc`'s polling run on
  /// 30-second intervals, so without this the close button would linger for up
  /// to half a minute after the trip went live. Status-driven transitions
  /// (driver en route, trip started) arrive over SignalR and need no timer.
  Timer? _windowTimer;
  DateTime? _scheduledWindowOpensAt;

  @override
  void dispose() {
    _windowTimer?.cancel();
    super.dispose();
  }

  /// (Re)arms the timer whenever the trip's window moves — the rider can edit a
  /// scheduled pickup time while the screen is open.
  void _syncWindowTimer(TripEntity? trip) {
    final opensAt = trip?.reservationWindowOpensAtUtc;

    if (opensAt == null || !trip!.isReservedFuture) {
      _windowTimer?.cancel();
      _windowTimer = null;
      _scheduledWindowOpensAt = null;
      return;
    }

    if (_windowTimer != null && _scheduledWindowOpensAt == opensAt) return;

    _windowTimer?.cancel();
    _scheduledWindowOpensAt = opensAt;
    final delay = opensAt.difference(DateTime.now().toUtc());
    _windowTimer = Timer(delay.isNegative ? Duration.zero : delay, () {
      if (!mounted) return;
      // Rebuild so the button goes at once, and let the cubit resolve the new
      // liveness so its listener below performs the hand-over.
      setState(() {});
      unawaited(getIt<ActiveTripCubit>().refresh());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final tripId =
        (state.extra as String?) ?? state.uri.queryParameters['id'] ?? '';

    return AppScaffold.body(
      child: BlocProvider<TripBloc>(
        create: (context) => getIt<TripBloc>()..add(TripEvent.started(tripId)),
        child: BlocListener<ActiveTripCubit, ActiveTripState>(
          bloc: getIt<ActiveTripCubit>(),
          // A reservation booked ~16 minutes out crosses its dispatch window
          // about a minute later. Hand it over to the Home tab rather than
          // leaving the rider on a screen that has become a live trip: this
          // route has no bottom bar, so keeping them here would trap them. Also
          // covers a deep link that lands on an already-live trip.
          listenWhen: (previous, current) => _isLiveInCubit(current, tripId),
          listener: (context, _) =>
              context.goNamed(RootScreen.pageName, extra: RootTab.home),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ActiveTripBody(),
              BlocBuilder<TripBloc, TripState>(
                builder: (context, tripState) {
                  final trip = tripState.tripStatus.getDataWhenSuccess;
                  _syncWindowTimer(trip);

                  // Gone the instant the ride is underway. Driven off the trip
                  // itself rather than the hand-over above, so a SignalR event
                  // removes it without waiting on the cubit's debounce.
                  if (trip == null || trip.isLiveNow) {
                    return const SizedBox.shrink();
                  }
                  return _CloseButton(
                    onTap: () =>
                        safePop(context, fallbackExtra: RootTab.trips),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static bool _isLiveInCubit(ActiveTripState state, String tripId) {
    for (final trip in state.trips) {
      if (trip.id == tripId) return trip.isLiveNow;
    }
    return false;
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // Top-RIGHT on purpose: `ActiveTripBody` pins its status banner card to
      // the top-left with an absolute `left:`, and that banner is present for
      // exactly the statuses this screen shows. An absolute `right:` keeps the
      // two apart in RTL too, since the banner lays itself out force-LTR.
      top: MediaQuery.paddingOf(context).top + AppSpacing.sm.h,
      right: AppSpacing.lg.w,
      child: AppButton.error(
        noShadow: true,
        layout: const AppButtonLayout(
          shape: AppButtonShape.circle,
          height: 42,
          // Zero padding so the icon centres on the circle. The default icon
          // padding is `.r`-scaled while the circle's size is `.h`-scaled, and
          // on devices where those factors differ the icon is pushed off
          // centre.
          contentPadding: EdgeInsets.zero,
        ),
        child: AppButtonChild.icon(IconSource.icon(Icons.close)),
        onTap: onTap,
      ),
    );
  }
}
