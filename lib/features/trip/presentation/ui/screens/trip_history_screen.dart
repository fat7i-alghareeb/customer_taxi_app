import 'package:customertaxi/common/imports/imports.dart';
import '../widgets/trip_history_body.dart';
import '../../states/trip_bloc.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  static const String pagePath = '/trip_history';
  static const String pageName = 'TripHistoryScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TripBloc>()..add(const TripEvent.historyStarted()),
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(
          title: AppStrings.tripHistoryTitle,
        ),
        child: const TripHistoryBody(),
      ),
    );
  }
}
