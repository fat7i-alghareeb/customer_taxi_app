import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_history_body.dart';

class RootTripTabSection extends StatelessWidget {
  const RootTripTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: REdgeInsets.only(top: AppSpacing.md),
        child: BlocProvider(
          create: (context) =>
              getIt<TripBloc>()..add(const TripEvent.historyStarted()),
          child: const TripHistoryBody(),
        ),
      ),
    );
  }
}
