import 'package:customertaxi/common/imports/imports.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../states/trip_bloc.dart';
import 'trip_summary_card.dart';

class TripHistoryBody extends StatelessWidget {
  const TripHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        return StatusBuilder<List<TripSummaryEntity>>(
          state: state.historyStatus,
          success: (data) => _TripHistoryList(
            trips: data,
            hasMore: state.hasMore,
            isLoadingMore: state.historyStatus.isLoading,
          ),
        );
      },
    );
  }
}

class _TripHistoryList extends StatelessWidget {
  const _TripHistoryList({
    required this.trips,
    required this.hasMore,
    required this.isLoadingMore,
  });

  final List<TripSummaryEntity> trips;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return EmptyStateWidget(text: AppStrings.tripHistoryEmpty);
    }

    return ListView.builder(
      padding: REdgeInsets.all(AppSpacing.xl),
      physics: const BouncingScrollPhysics(),
      itemCount: trips.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == trips.length) {
          return Padding(
            padding: REdgeInsets.symmetric(vertical: AppSpacing.md),
            child: isLoadingMore
                ? Center(child: LoadingDots(color: context.primary))
                : AppButton.grey(
                    onTap: () => context.read<TripBloc>().add(
                          const TripEvent.nextPageRequested(),
                        ),
                    child: AppButtonChild.label(AppStrings.tripHistoryLoadMore),
                  ),
          );
        }
        return TripSummaryCard(trip: trips[index]);
      },
    );
  }
}
