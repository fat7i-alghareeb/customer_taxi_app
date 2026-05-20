import 'package:customertaxi/common/imports/imports.dart';

/// A premium, modern CTA card used in the home screen header.
///
/// Features a large centered vehicle or scheduling 3D asset,
/// localized title and subtitle, and an optional custom positioned badge.
class RootHeaderCtaCard extends StatelessWidget {
  const RootHeaderCtaCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Widget image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.h,
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(
            color: context.onSurface.withValues(alpha: 0.06),
            width: 1.r,
          ),
          boxShadow: context.shadows.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: image,
            ),
            AppSpacing.sm.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s16w700.copyWith(
                color: context.onSurface,
              ),
            ),
            AppSpacing.xs.verticalSpace,
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
