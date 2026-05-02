import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/constants/root_constants.dart';

class RootHeaderSearchPillWidget extends StatelessWidget {
  const RootHeaderSearchPillWidget({super.key, required this.onSearchTap});

  final VoidCallback onSearchTap;

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
                  AppSpacing.sm.horizontalSpace,
                  Expanded(
                    child: AppButton.variant(
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
                                  color: context.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
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
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: AppDurations.normal)
              .slideY(begin: -0.1, end: 0, curve: Curves.easeOutCubic),
    );
  }
}
