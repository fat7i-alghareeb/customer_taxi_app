import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/constants/root_constants.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/home/root_header_cta_card.dart';

class RootHomeBottomSheet extends StatelessWidget {
  const RootHomeBottomSheet({
    super.key,
    required this.onSearchTap,
    required this.onLaterTap,
    this.discountPercent = 0.0,
  });

  final VoidCallback onSearchTap;
  final VoidCallback onLaterTap;
  final double discountPercent;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child:
          AppBottomSheet.basic(
                scrollable: false,
                padding: REdgeInsets.only(
                  left: AppSpacing.xl,
                  right: AppSpacing.xl,
                  top: AppSpacing.md,
                  bottom: AppSpacing.xl,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppDiscountBanner(discountPercent: discountPercent),
                    AppSpacing.md.verticalSpace,
                    Text(
                      AppStrings.yourJourneyBeginsHere,
                      style: AppTextStyles.s22w700.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    AppSpacing.md.verticalSpace,
                    Row(
                      children: [
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
                        AppSpacing.md.horizontalSpace,
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
                                  color: context.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
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
                                    color: context.primary.withValues(
                                      alpha: 0.3,
                                    ),
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
                ),
              )
              .animate()
              .fadeIn(duration: AppDurations.normal)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
    );
  }
}
