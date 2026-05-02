import 'package:customertaxi/common/imports/imports.dart';

class DrawerBalanceCard extends StatelessWidget {
  const DrawerBalanceCard({
    super.key,
    required this.balance,
    required this.onAddTap,
  });

  final String balance;
  final VoidCallback onAddTap;

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
                AppStrings.drawerBalance,
                style: AppTextStyles.s14w400.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                balance,
                style: AppTextStyles.s28w700.copyWith(
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ],
          ),
          // Add Button
          Material(
            color: Colors.black.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            child: InkWell(
              onTap: onAddTap,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              child: Container(
                padding: REdgeInsets.all(AppSpacing.md),
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 20.r,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().scale(delay: AppDurations.fast);
  }
}
