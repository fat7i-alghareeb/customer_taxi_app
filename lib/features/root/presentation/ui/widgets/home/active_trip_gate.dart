import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/active_trip_body.dart';

import 'active_trip_loading_section.dart';
import 'root_home_tab_section.dart';

/// Home-tab content switch: shows the live active-trip view (which joins the
/// trip's SignalR channel via [TripEvent.started]) when the passenger has an
/// ongoing trip, otherwise the normal booking flow.
class ActiveTripGate extends StatelessWidget {
  const ActiveTripGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActiveTripCubit>.value(
      value: getIt<ActiveTripCubit>(),
      child: BlocBuilder<ActiveTripCubit, ActiveTripState>(
        builder: (context, state) {
          // The second condition covers the window right after a booking
          // succeeds: `markBookingPending()` flips `loading` before the
          // async `refresh()` resolves, so the bookable Home pill stays
          // hidden instead of flashing while the new trip is fetched.
          if (!state.loaded || (state.loading && !state.hasActiveTrip)) {
            return const ActiveTripLoadingSection();
          }

          if (state.hasActiveTrip) {
            final trip = state.trip!;
            return BlocProvider<TripBloc>(
              // Key by trip id only: the TripBloc already tracks status changes
              // internally (polling + realtime), so keying by status would tear
              // down and recreate the bloc on every transition — losing the live
              // marker animation and re-subscribing needlessly.
              key: ValueKey('active-trip-${trip.id}'),
              create: (_) => getIt<TripBloc>()..add(TripEvent.started(trip.id)),
              child: const ActiveTripBody(),
            );
          }
          return const RootHomeTabSection();
        },
      ),
    );
  }
}
