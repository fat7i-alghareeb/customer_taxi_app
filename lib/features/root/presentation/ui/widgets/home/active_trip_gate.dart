import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/active_trip_body.dart';

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
          if (!state.loaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasActiveTrip) {
            final trip = state.trip!;
            return BlocProvider<TripBloc>(
              key: ValueKey('active-trip-${trip.id}-${trip.status.name}'),
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
