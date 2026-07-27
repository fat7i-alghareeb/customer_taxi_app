import 'package:customertaxi/common/imports/imports.dart';

import 'trip_card.dart';

/// One titled group of trips in the Trips tab (Ongoing / Upcoming / Past).
///
/// Returns slivers rather than a widget so all three groups scroll as a single
/// list instead of three nested scroll views.
List<Widget> tripGroupSlivers(
  BuildContext context, {
  required String title,
  required List<TripCardData> trips,
  required TripCardVariant variant,
  Color? titleColor,
}) {
  if (trips.isEmpty) return const [];

  return [
    SliverPadding(
      padding: REdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.xl,
        bottom: AppSpacing.sm,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyles.s16w700.copyWith(
                color: titleColor ?? context.onSurface,
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            Container(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: (titleColor ?? context.onSurface).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadii.sm.r),
              ),
              child: Text(
                '${trips.length}',
                style: AppTextStyles.s12w700.copyWith(
                  color: titleColor ?? context.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    SliverPadding(
      padding: REdgeInsets.symmetric(horizontal: AppSpacing.xl),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              TripCard(trip: trips[index], variant: variant),
          childCount: trips.length,
        ),
      ),
    ),
  ];
}
