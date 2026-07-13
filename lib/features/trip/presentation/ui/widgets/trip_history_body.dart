import 'package:customertaxi/common/imports/imports.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../states/trip_bloc.dart';
import 'trip_history_skeleton.dart';
import 'trip_summary_card.dart';

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
    return Column(
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
                success: (data) => _TripHistoryList(
                  controller: _scrollController,
                  trips: data,
                  hasMore: state.hasMore,
                  isLoadingMore: state.isLoadingMore,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TripHistoryList extends StatelessWidget {
  const _TripHistoryList({
    required this.controller,
    required this.trips,
    required this.hasMore,
    required this.isLoadingMore,
  });

  final ScrollController controller;
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
      controller: controller,
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
        if (hasMore && isLoadingMore)
          SliverPadding(
            padding: REdgeInsets.all(AppSpacing.xl),
            sliver: SliverToBoxAdapter(
              child: Center(child: LoadingDots(color: context.primary)),
            ),
          ),
      ],
    );
  }
}
