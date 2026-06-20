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

    final upcoming = trips
        .where((t) => t.scheduledAtUtc != null && !t.status.isTerminal)
        .toList();
    final past = trips
        .where((t) => t.scheduledAtUtc == null || t.status.isTerminal)
        .toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (upcoming.isNotEmpty) ...[
          SliverPadding(
            padding: REdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.xl,
              bottom: AppSpacing.sm,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                AppStrings.upcomingTrips,
                style: AppTextStyles.s16w700.copyWith(color: context.primary),
              ),
            ),
          ),
          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: REdgeInsets.only(bottom: AppSpacing.md),
                  child: TripSummaryCard(trip: upcoming[index]),
                ),
                childCount: upcoming.length,
              ),
            ),
          ),
        ],
        if (past.isNotEmpty) ...[
          SliverPadding(
            padding: REdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.xl,
              bottom: AppSpacing.sm,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                AppStrings.pastTrips,
                style: AppTextStyles.s16w700.copyWith(color: context.onSurface),
              ),
            ),
          ),
          SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: REdgeInsets.only(bottom: AppSpacing.md),
                  child: TripSummaryCard(trip: past[index]),
                ),
                childCount: past.length,
              ),
            ),
          ),
        ],
        if (hasMore)
          SliverPadding(
            padding: REdgeInsets.all(AppSpacing.xl),
            sliver: SliverToBoxAdapter(
              child: isLoadingMore
                  ? Center(child: LoadingDots(color: context.primary))
                  : AppButton.grey(
                      onTap: () => context.read<TripBloc>().add(
                            const TripEvent.nextPageRequested(),
                          ),
                      child: AppButtonChild.label(AppStrings.tripHistoryLoadMore),
                    ),
            ),
          ),
      ],
    );
  }
}
