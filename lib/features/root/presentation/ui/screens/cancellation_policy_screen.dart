import 'package:customertaxi/common/imports/imports.dart';

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
    );
  }
}
