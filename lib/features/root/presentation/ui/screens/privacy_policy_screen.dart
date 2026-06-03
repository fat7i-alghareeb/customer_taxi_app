import 'package:customertaxi/common/imports/imports.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const String pagePath = '/privacy-policy';
  static const String pageName = 'PrivacyPolicyScreen';

  @override
  Widget build(BuildContext context) {
    final sections = <(String, String)>[
      (AppStrings.privacyPolicyDataCollectedTitle,
          AppStrings.privacyPolicyDataCollectedBody),
      (AppStrings.privacyPolicyPurposesTitle,
          AppStrings.privacyPolicyPurposesBody),
      (AppStrings.privacyPolicyRightsTitle,
          AppStrings.privacyPolicyRightsBody),
      (AppStrings.privacyPolicyAccountDeletionTitle,
          AppStrings.privacyPolicyAccountDeletionBody),
    ];

    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(
        title: AppStrings.privacyPolicyTitle,
      ),
      child: ListView.separated(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.lg.w,
          vertical: AppSpacing.lg.h,
        ),
        itemCount: sections.length + 1,
        separatorBuilder: (_, _) => AppSpacing.xl.verticalSpace,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Text(
              AppStrings.privacyPolicyIntro,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurface,
                height: 1.55,
              ),
            ).animate().fadeIn(duration: AppDurations.normal);
          }
          final (title, body) = sections[index - 1];
          return PolicySection(
            title: title,
            body: body,
            index: index,
          );
        },
      ),
    );
  }
}
