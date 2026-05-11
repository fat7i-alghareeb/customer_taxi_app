import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/constants/root_constants.dart';

class RootHeaderSearchPillWidget extends StatelessWidget {
  const RootHeaderSearchPillWidget({
    super.key,
    required this.onSearchTap,
    required this.onLaterTap,
  });

  final VoidCallback onSearchTap;
  final VoidCallback onLaterTap;

  void _openDrawer(BuildContext context) {
    final scaffold = Scaffold.maybeOf(context);
    scaffold?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.topPadding + AppSpacing.md.h,
      left: AppSpacing.md.w,
      right: AppSpacing.md.w,
      child:
          Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      AppButton.variant(
                        variant: AppButtonVariant.grey,
                        fill: AppButtonFill.solid,
                        onTap: () => _openDrawer(context),
                        layout: AppButtonLayout(
                          shape: AppButtonShape.circle,
                          height: RootConstants.headerMenuSize.sp,
                          backgroundColor: context.surface,
                          contentPadding: REdgeInsets.all(AppSpacing.sm),
                        ),
                        customShadows: context.shadows.grey,
                        child: AppButtonChild.custom(
                          FaIcon(
                            FontAwesomeIcons.bars,
                            size: 18.r,
                            color: context.onSurface,
                          ),
                        ),
                      ),
                      AppSpacing.md.horizontalSpace,
                      Expanded(
                        child: Text(
                          AppStrings.happyToSeeYou,
                          style: AppTextStyles.s22w700.copyWith(
                            // color: context.primary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.md.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: _SimpleHeaderCta(
                          icon: FontAwesomeIcons.car,
                          label: AppStrings.bookARideNow,
                          onTap: onSearchTap,
                        ),
                      ),
                      AppSpacing.md.horizontalSpace,
                      Expanded(
                        child: _SimpleHeaderCta(
                          icon: FontAwesomeIcons.calendarCheck,
                          label: AppStrings.scheduleARideInAdvance,
                          onTap: onLaterTap,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.md.verticalSpace,
                  AppButton.variant(
                    variant: AppButtonVariant.grey,
                    fill: AppButtonFill.solid,
                    onTap: onSearchTap,
                    layout: AppButtonLayout(
                      shape: AppButtonShape.pill,
                      height: RootConstants.headerPillHeight.sp,
                      backgroundColor: context.surface,
                      contentPadding: REdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                    customShadows: context.shadows.grey,
                    child: AppButtonChild.custom(
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppStrings.whereTo,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.s14w600.copyWith(
                                color: context.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                          AppSpacing.sm.horizontalSpace,
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: onLaterTap,
                            child: Container(
                              padding: REdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: context.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  AppRadii.xl.r,
                                ),
                                border: Border.all(
                                  color: context.primary.withValues(alpha: 0.3),
                                  width: 1.r,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.clock,
                                    size: 11.r,
                                    color: context.primary,
                                  ),
                                  AppSpacing.xs.horizontalSpace,
                                  Text(
                                    AppStrings.later,
                                    style: AppTextStyles.s12w700.copyWith(
                                      color: context.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AppSpacing.sm.horizontalSpace,
                          FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 18.r,
                            color: context.onSurface.withValues(alpha: 0.7),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: AppDurations.normal)
              .slideY(begin: -0.1, end: 0, curve: Curves.easeOutCubic),
    );
  }
}

class _SimpleHeaderCta extends StatelessWidget {
  const _SimpleHeaderCta({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          boxShadow: context.shadows.grey,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: 14.r, color: context.primary),
            AppSpacing.sm.horizontalSpace,
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s12w700.copyWith(color: context.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
