
import 'package:customertaxi/common/imports/imports.dart';

class AppDiscountBanner extends StatelessWidget {
  const AppDiscountBanner({
    super.key,
    required this.discountPercent,
  });

  final double discountPercent;

  @override
  Widget build(BuildContext context) {
    if (discountPercent <= 0) return const SizedBox.shrink();

    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.primary,
            context.primary.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
      ),
      child: Row(
        children: [
          FaIcon(
            FontAwesomeIcons.tag,
            size: 14.r,
            color: context.onPrimary,
          ),
          AppSpacing.sm.horizontalSpace,
          Text(
            AppStrings.discountApplied.replaceAll(
              '{percent}',
              discountPercent.toStringAsFixed(0),
            ),
            style: AppTextStyles.s14w700.copyWith(
              color: context.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
