import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/root_screen.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/root_body.dart';

class CancellationPolicyScreen extends StatelessWidget {
  const CancellationPolicyScreen({super.key});

  static const pagePath = '/cancellation-policy';
  static const pageName = 'cancellation-policy';

  @override
  Widget build(BuildContext context) {
    final sections = <(String, List<String>)>[
      (
        AppStrings.cancellationPolicyCancellationHeading,
        <String>[
          AppStrings.cancellationPolicyCancel1,
          AppStrings.cancellationPolicyCancel2,
          AppStrings.cancellationPolicyCancel3,
          AppStrings.cancellationPolicyCancel4,
        ],
      ),
      (
        AppStrings.cancellationPolicyAirportHeading,
        <String>[
          AppStrings.cancellationPolicyAirport1,
          AppStrings.cancellationPolicyAirport2,
          AppStrings.cancellationPolicyAirport3,
        ],
      ),
    ];

    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(
        title: AppStrings.cancellationPolicyTitle,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.lg.w,
                vertical: AppSpacing.lg.h,
              ),
              children: [
                for (final (heading, bullets) in sections) ...[
                  Text(
                    heading,
                    style: AppTextStyles.s18w600.copyWith(
                      color: context.primary,
                    ),
                  ).animate().fadeIn(duration: 220.ms),
                  AppSpacing.md.verticalSpace,
                  for (final bullet in bullets) ...[
                    _PolicyBullet(text: bullet),
                    AppSpacing.lg.verticalSpace,
                  ],
                  AppSpacing.md.verticalSpace,
                ],
              ],
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

class _PolicyBullet extends StatelessWidget {
  const _PolicyBullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
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
            text,
            style: AppTextStyles.s14w400.copyWith(
              color: context.onSurface,
              height: 1.45,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.06, end: 0);
  }
}
