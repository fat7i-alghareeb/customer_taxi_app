import 'package:customertaxi/common/imports/imports.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../states/active_trip_cubit.dart';
import '../../states/trip_bloc.dart';
import 'trip_card.dart';
import 'trip_group_section.dart';
import 'trip_history_skeleton.dart';

/// The Trips tab.
///
/// Trips are grouped into Ongoing / Upcoming / Past. The first two groups are
/// sourced from [ActiveTripCubit] rather than the paged history, because only
/// the full [TripEntity] carries the dispatch window that decides whether a
/// scheduled trip is still a reservation — and because those groups then stay
/// complete regardless of paging and update on realtime events for free.
class TripHistoryBody extends StatefulWidget {
  const TripHistoryBody({super.key});

  @override
  State<TripHistoryBody> createState() => _TripHistoryBodyState();
}

class _TripHistoryBodyState extends State<TripHistoryBody> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      final bloc = context.read<TripBloc>();
      final state = bloc.state;
      if (state.hasMore &&
          !state.historyStatus.isLoading &&
          !state.isLoadingMore) {
        bloc.add(const TripEvent.nextPageRequested());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActiveTripCubit, ActiveTripState>(
      // The paged history is a plain snapshot — without this it would still
      // show a cancelled or completed trip as ongoing until the tab is
      // reopened. `ActiveTripCubit` already refreshes on realtime events, so
      // reacting to its trip set keeps the list honest.
      listenWhen: (previous, current) =>
          _tripSignature(previous.trips) != _tripSignature(current.trips),
      listener: (context, _) =>
          context.read<TripBloc>().add(const TripEvent.historyStarted()),
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.sm,
            ),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onChanged: (value) =>
                  context.read<TripBloc>().add(TripEvent.searchChanged(value)),
              decoration: InputDecoration(
                hintText: AppStrings.tripHistorySearchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context
                              .read<TripBloc>()
                              .add(const TripEvent.searchChanged(''));
                          setState(() {});
                        },
                      ),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TripBloc, TripState>(
              builder: (context, state) {
                return StatusBuilder<List<TripSummaryEntity>>(
                  state: state.historyStatus,
                  loading: () => const TripHistorySkeletonList(),
                  success: (data) => _TripGroupedList(
                    controller: _scrollController,
                    history: data,
                    hasMore: state.hasMore,
                    isLoadingMore: state.isLoadingMore,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Ids + statuses, so the history reloads when a trip appears, disappears or
  /// changes state, but not on every unrelated emission.
  String _tripSignature(List<TripEntity> trips) =>
      trips.map((t) => '${t.id}:${t.status.name}').join(',');
}

class _TripGroupedList extends StatelessWidget {
  const _TripGroupedList({
    required this.controller,
    required this.history,
    required this.hasMore,
    required this.isLoadingMore,
  });

  final ScrollController controller;
  final List<TripSummaryEntity> history;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTripCubit, ActiveTripState>(
      builder: (context, activeState) {
        final ongoing = activeState.trips
            .where((t) => t.isLiveNow)
            .map(TripCardData.fromTrip)
            .toList();
        final upcoming = activeState.reservedTrips
            .map(TripCardData.fromTrip)
            .toList();

        // Anything already shown above is dropped from the history section, so
        // a live trip never appears twice. This also fixes the old split, which
        // filed an in-flight immediate trip under "Past trips" because it had
        // no scheduled time.
        final shownIds = {
          ...ongoing.map((t) => t.id),
          ...upcoming.map((t) => t.id),
        };
        final past = history
            .where((t) => !shownIds.contains(t.id))
            .map(TripCardData.fromSummary)
            .toList();

        if (ongoing.isEmpty && upcoming.isEmpty && past.isEmpty) {
          return EmptyStateWidget(text: AppStrings.tripHistoryEmpty);
        }

        return CustomScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          slivers: [
            ...tripGroupSlivers(
              context,
              title: AppStrings.tripsGroupOngoing,
              trips: ongoing,
              variant: TripCardVariant.live,
              titleColor: AppColors.tripOrange,
            ),
            ...tripGroupSlivers(
              context,
              title: AppStrings.upcomingTrips,
              trips: upcoming,
              variant: TripCardVariant.upcoming,
              titleColor: context.primary,
            ),
            ...tripGroupSlivers(
              context,
              title: AppStrings.pastTrips,
              trips: past,
              variant: TripCardVariant.past,
            ),
            if (hasMore && isLoadingMore)
              SliverPadding(
                padding: REdgeInsets.all(AppSpacing.xl),
                sliver: SliverToBoxAdapter(
                  child: Center(child: LoadingDots(color: context.primary)),
                ),
              ),
            SliverToBoxAdapter(child: AppSpacing.xl.verticalSpace),
          ],
        );
      },
    );
  }
}
