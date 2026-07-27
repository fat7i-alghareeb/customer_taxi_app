import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/states/reservation_confirmation_cubit.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/active_trip_body.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/reservation_confirmed_overlay.dart';

import 'active_trip_loading_section.dart';
import 'root_home_tab_section.dart';

/// Home-tab content switch: shows the live active-trip view (which joins the
/// trip's SignalR channel via [TripEvent.started]) when the passenger has a trip
/// underway, otherwise the normal booking flow.
///
/// Only a *live* trip takes the tab. Future scheduled reservations deliberately
/// leave the booking flow reachable — the passenger may hold several — and
/// surface as [ReservedTripsBanner] over the map instead.
class ActiveTripGate extends StatelessWidget {
  const ActiveTripGate({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveTripCubit>.value(value: getIt<ActiveTripCubit>()),
        BlocProvider<ReservationConfirmationCubit>.value(
          value: getIt<ReservationConfirmationCubit>(),
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          BlocBuilder<ActiveTripCubit, ActiveTripState>(
            builder: (context, state) {
              // The second condition covers the window right after a booking
              // succeeds: `markBookingPending()` flips `loading` before the
              // async `refresh()` resolves, so the bookable Home pill stays
              // hidden instead of flashing while the new trip is fetched.
              if (!state.loaded || (state.loading && !state.hasLiveTrip)) {
                return const ActiveTripLoadingSection();
              }

              if (state.liveTrip case final trip?) {
                return BlocProvider<TripBloc>(
                  // Key by trip id only: the TripBloc already tracks status
                  // changes internally (polling + realtime), so keying by status
                  // would tear down and recreate the bloc on every transition —
                  // losing the live marker animation and re-subscribing
                  // needlessly.
                  key: ValueKey('active-trip-${trip.id}'),
                  create: (_) =>
                      getIt<TripBloc>()..add(TripEvent.started(trip.id)),
                  child: const ActiveTripBody(),
                );
              }
              return const RootHomeTabSection();
            },
          ),
          // Sits outside the builder above so the confirmation survives the
          // loading state a fresh booking puts the gate into.
          BlocBuilder<ReservationConfirmationCubit, String?>(
            builder: (context, tripId) {
              if (tripId == null) return const SizedBox.shrink();
              return ReservationConfirmedOverlay(
                onDismiss: () =>
                    context.read<ReservationConfirmationCubit>().dismiss(),
              );
            },
          ),
        ],
      ),
    );
  }
}
