import 'package:customertaxi/common/imports/imports.dart';

class DrawerTripsCountCard extends StatelessWidget {
  const DrawerTripsCountCard({
    super.key,
    required this.tripsCount,
  });

  final int tripsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: REdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: BorderRadius.circular(AppRadii.xl.r),
        boxShadow: [
          BoxShadow(
            color: context.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.drawerTotalTrips,
                style: AppTextStyles.s14w400.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                tripsCount.toString(),
                style: AppTextStyles.s28w700.copyWith(
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ],
          ),
          FaIcon(
            FontAwesomeIcons.carSide,
            color: Colors.white.withValues(alpha: 0.2),
            size: 48.r,
          ),
        ],
      ),
    ).animate().fadeIn().scale(delay: AppDurations.fast);
  }
}
