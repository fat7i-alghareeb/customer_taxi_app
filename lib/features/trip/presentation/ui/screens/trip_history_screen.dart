import 'package:customertaxi/common/imports/imports.dart';
import '../widgets/trip_history_body.dart';
import '../../states/active_trip_cubit.dart';
import '../../states/trip_bloc.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  static const String pagePath = '/trip_history';
  static const String pageName = 'TripHistoryScreen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<TripBloc>()..add(const TripEvent.historyStarted()),
        ),
        BlocProvider<ActiveTripCubit>.value(value: getIt<ActiveTripCubit>()),
      ],
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(
          title: AppStrings.tripHistoryTitle,
        ),
        child: const TripHistoryBody(),
      ),
    );
  }
}
