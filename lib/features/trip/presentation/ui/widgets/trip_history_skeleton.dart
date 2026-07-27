import 'package:customertaxi/common/imports/imports.dart';

/// Loading placeholder for [TripHistoryBody], shown while `historyStatus` is
/// `loading`. Mirrors `TripCard`'s layout (title+chip row, route block, divider,
/// date/fare row) so the swap to real data doesn't jump.
class TripHistorySkeletonList extends StatelessWidget {
  const TripHistorySkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: REdgeInsets.all(AppSpacing.xl),
      itemCount: 5,
      itemBuilder: (context, index) => const _TripHistorySkeletonCard(),
    );
  }
}

class _TripHistorySkeletonCard extends StatelessWidget {
  const _TripHistorySkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: REdgeInsets.only(bottom: AppSpacing.md),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        side: BorderSide(
          color: context.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppShimmer.box(width: 90, height: 16),
                AppShimmer.box(width: 64, height: 20, borderRadius: 20),
              ],
            ),
            AppSpacing.md.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer.box(width: 9, height: 42, borderRadius: 6),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmer.box(width: 180, height: 14),
                      AppSpacing.md.verticalSpace,
                      AppShimmer.box(width: 140, height: 14),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.md.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppShimmer.box(width: 90, height: 12),
                AppShimmer.box(width: 70, height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
