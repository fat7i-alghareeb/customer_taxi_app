import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import '../widgets/active_trip_body.dart';

class ActiveTripScreen extends StatelessWidget {
  const ActiveTripScreen({super.key});

  static const String pagePath = '/active_trip';
  static const String pageName = 'ActiveTripScreen';

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final tripId = (state.extra as String?) ?? state.uri.queryParameters['id'] ?? '';

    return AppScaffold.body(
      child: BlocProvider<TripBloc>(
        create: (context) => getIt<TripBloc>()..add(TripEvent.started(tripId)),
        child: const ActiveTripBody(),
      ),
    );
  }
}
