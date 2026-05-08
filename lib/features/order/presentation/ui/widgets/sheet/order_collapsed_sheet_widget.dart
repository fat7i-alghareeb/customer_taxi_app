import 'package:customertaxi/common/imports/imports.dart';

import '../../../../constants/order_constants.dart';
import '../../../states/order_bloc.dart';

class OrderCollapsedSheetWidget extends StatelessWidget {
  const OrderCollapsedSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    printM('[OrderCollapsedSheetWidget] build');
    return Padding(
          padding: REdgeInsets.symmetric(
            vertical: OrderConstants.collapsedSheetVerticalPadding,
          ),
          child: Material(
            color: context.isDarkTheme
                ? context.primary.withValues(alpha: 0.6)
                : context.primary,
            elevation: 8,
            // shadowColor: context.grey,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              onTap: () {
                printM('[OrderCollapsedSheetWidget] hero tapped -> expanded');
                context.read<OrderBloc>().add(
                  const OrderEvent.orderNowPressed(),
                );
              },
              child: Container(
                width: double.maxFinite,
                height: OrderConstants.collapsedHeroHeight.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                  border: Border.all(
                    color: context.primary.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Note: Accent block removed to achieve solid-color flat design as requested

                    // Content
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                      AppStrings.planYourTrip.toUpperCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.s12w500.copyWith(
                                        color: context.onPrimary,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 200.ms)
                                    .slideX(
                                      begin: -0.1,
                                      curve: Curves.easeOutQuart,
                                    ),
                                AppSpacing.xs.verticalSpace,
                                Text(
                                      AppStrings.orderNow,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.s28w700.copyWith(
                                        color: context.onPrimary,
                                        height: 1.1,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 300.ms)
                                    .scale(
                                      alignment: Alignment.centerLeft,
                                      curve: Curves.easeOutBack,
                                    ),
                                AppSpacing.md.verticalSpace,
                                Container(
                                      padding: REdgeInsets.symmetric(
                                        horizontal: AppSpacing.md,
                                        vertical: AppSpacing.xs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: context.surface,
                                        borderRadius: BorderRadius.circular(
                                          999.r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: FittedBox(
                                              child: Text(
                                                AppStrings.searchToLocation,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles.s12w400
                                                    .copyWith(
                                                      color: context.onSurface,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          AppSpacing.xs.horizontalSpace,
                                          FaIcon(
                                            FontAwesomeIcons.chevronRight,
                                            size: 10.r,
                                            color: context.primary,
                                          ),
                                        ],
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 400.ms)
                                    .moveY(
                                      begin: 10,
                                      end: 0,
                                      curve: Curves.easeOutQuart,
                                    ),
                              ],
                            ),
                          ),

                          // Bleeding Image
                          Transform.translate(
                                offset: Offset(20.w, 5.h),
                                child: Assets.images.orderNowCar
                                    .image(
                                      width: OrderConstants
                                          .collapsedHeroImageSize
                                          .w,
                                      height:
                                          (OrderConstants
                                                      .collapsedHeroImageSize *
                                                  0.8)
                                              .h,
                                      fit: BoxFit.contain,
                                    )
                                    .animate(
                                      onPlay: (c) => c.repeat(reverse: true),
                                    )
                                    .moveY(
                                      begin: 0,
                                      end: -4.h,
                                      duration: 2000.ms,
                                      curve: Curves.easeInOut,
                                    ),
                              )
                              .animate()
                              .fadeIn(delay: 500.ms)
                              .slideX(begin: 0.1, curve: Curves.easeOutQuart),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutBack);
  }
}
