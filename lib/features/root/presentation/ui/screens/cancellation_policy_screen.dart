import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/root_screen.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/root_body.dart';

class CancellationPolicyScreen extends StatelessWidget {
  const CancellationPolicyScreen({super.key});

  static const pagePath = '/cancellation-policy';
  static const pageName = 'cancellation-policy';

  @override
  Widget build(BuildContext context) {
    final paragraphs = <String>[
      AppStrings.cancellationPolicyPassengerWindow,
      AppStrings.cancellationPolicyDriverLate,
      AppStrings.cancellationPolicyPassengerLate,
      AppStrings.cancellationPolicyWaitingFee,
      AppStrings.cancellationPolicyRefundTiming,
    ];

    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(
        title: AppStrings.cancellationPolicyTitle,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.lg.w,
                vertical: AppSpacing.lg.h,
              ),
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: REdgeInsets.only(top: 2),
                      child: FaIcon(
                        FontAwesomeIcons.circleCheck,
                        size: 16.sp,
                        color: context.primary,
                      ),
                    ),
                    AppSpacing.md.horizontalSpace,
                    Expanded(
                      child: Text(
                        paragraphs[index],
                        style: AppTextStyles.s14w400.copyWith(
                          color: context.onSurface,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.06, end: 0);
              },
              separatorBuilder: (_, _) => AppSpacing.lg.verticalSpace,
              itemCount: paragraphs.length,
            ),
          ),
          Container(
            padding: REdgeInsets.all(AppSpacing.lg),
            margin: REdgeInsets.only(
              left: AppSpacing.lg.w,
              right: AppSpacing.lg.w,
              bottom: context.bottomPadding > 0
                  ? context.bottomPadding
                  : AppSpacing.lg.h,
            ),
            decoration: BoxDecoration(
              color: context.surfaceContainer,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              boxShadow: context.shadows.grey,
              border: Border.all(
                color: context.grey.withValues(alpha: 0.15),
                width: 1.r,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: REdgeInsets.only(top: 2),
                      child: FaIcon(
                        FontAwesomeIcons.circleInfo,
                        size: 16.sp,
                        color: context.primary,
                      ),
                    ),
                    AppSpacing.md.horizontalSpace,
                    Expanded(
                      child: Text(
                        AppStrings.cancellationPolicyHowToCancel,
                        style: AppTextStyles.s14w400.copyWith(
                          color: context.onSurface,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.lg.verticalSpace,
                AppButton.primaryGradient(
                  child: AppButtonChild.label(
                    AppStrings.cancellationPolicyGoToTrips,
                    textStyle: AppTextStyles.s14w600,
                  ),
                  onTap: () {
                    context.goNamed(RootScreen.pageName, extra: RootTab.trips);
                  },
                ),
              ],
            ),
          ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }
}
