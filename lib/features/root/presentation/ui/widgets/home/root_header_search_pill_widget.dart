import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/constants/root_constants.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/home/root_header_cta_card.dart';

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
                        child: RootHeaderCtaCard(
                          title: AppStrings.homeCtaTrips,
                          subtitle: AppStrings.homeCtaLetMove,
                          image: Image.asset(
                            Assets.images.normalTrip.path,
                            fit: BoxFit.contain,
                          ),
                          onTap: onSearchTap,
                        ),
                      ),
                      AppSpacing.md.horizontalSpace,
                      Expanded(
                        child: RootHeaderCtaCard(
                          title: AppStrings.homeCtaSchedule,
                          subtitle: AppStrings.homeCtaBookInAdvance,
                          image: Image.asset(
                            Assets.images.schdedulTrip.path,
                            fit: BoxFit.contain,
                          ),
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
