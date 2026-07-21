import 'package:customertaxi/common/imports/imports.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const String pagePath = '/privacy-policy';
  static const String pageName = 'PrivacyPolicyScreen';

  @override
  Widget build(BuildContext context) {
    final sections = <(String, String)>[
      (AppStrings.privacyPolicyIntroTitle, AppStrings.privacyPolicyIntro),
      (AppStrings.privacyPolicyAboutUsTitle,
          AppStrings.privacyPolicyAboutUsBody),
      (AppStrings.privacyPolicyDataCollectedTitle,
          AppStrings.privacyPolicyDataCollectedBody),
      (AppStrings.privacyPolicyCameraTitle, AppStrings.privacyPolicyCameraBody),
      (AppStrings.privacyPolicyAudioTitle, AppStrings.privacyPolicyAudioBody),
      (AppStrings.privacyPolicyRetentionTitle,
          AppStrings.privacyPolicyRetentionBody),
      (AppStrings.privacyPolicySharingTitle,
          AppStrings.privacyPolicySharingBody),
      (AppStrings.privacyPolicyMarketingTitle,
          AppStrings.privacyPolicyMarketingBody),
      (AppStrings.privacyPolicyCookiesTitle,
          AppStrings.privacyPolicyCookiesBody),
      (AppStrings.privacyPolicyPushNotificationsTitle,
          AppStrings.privacyPolicyPushNotificationsBody),
      (AppStrings.privacyPolicyRightsTitle,
          AppStrings.privacyPolicyRightsBody),
      (AppStrings.privacyPolicySecurityTitle,
          AppStrings.privacyPolicySecurityBody),
      (AppStrings.privacyPolicyResponsibilityTitle,
          AppStrings.privacyPolicyResponsibilityBody),
      (AppStrings.privacyPolicyAccountDeletionTitle,
          AppStrings.privacyPolicyAccountDeletionBody),
      (AppStrings.privacyPolicyChildrenTitle,
          AppStrings.privacyPolicyChildrenBody),
      (AppStrings.privacyPolicyChangesTitle,
          AppStrings.privacyPolicyChangesBody),
      (AppStrings.privacyPolicyContactTitle,
          AppStrings.privacyPolicyContactBody),
      (AppStrings.privacyPolicyApplicableLawTitle,
          AppStrings.privacyPolicyApplicableLawBody),
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
              AppStrings.privacyPolicyEffectiveDate,
              style: AppTextStyles.s14w400.copyWith(
                color: context.onSurfaceVariant,
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
