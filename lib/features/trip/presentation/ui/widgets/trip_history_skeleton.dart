import 'package:customertaxi/common/imports/imports.dart';

/// Loading placeholder for [TripHistoryBody], shown while `historyStatus` is
/// `loading`. Mirrors `TripSummaryCard`'s layout (title+chip row, date line,
/// fare row) so the swap to real data doesn't jump.
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
            AppSpacing.sm.verticalSpace,
            AppShimmer.box(width: 120, height: 12),
            AppSpacing.md.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppShimmer.box(width: 60, height: 14),
                AppShimmer.box(width: 70, height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
