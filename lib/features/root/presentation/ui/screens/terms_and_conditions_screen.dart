import 'package:customertaxi/common/imports/imports.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  static const String pagePath = '/terms-and-conditions';
  static const String pageName = 'TermsAndConditionsScreen';

  @override
  Widget build(BuildContext context) {
    final sections = <(String, String)>[
      (AppStrings.termsServicesTitle, AppStrings.termsServicesBody),
      (AppStrings.termsReservationsTitle, AppStrings.termsReservationsBody),
      (AppStrings.termsPricingTitle, AppStrings.termsPricingBody),
      (AppStrings.termsPaymentTitle, AppStrings.termsPaymentBody),
      (AppStrings.termsClientResponsibilityTitle,
          AppStrings.termsClientResponsibilityBody),
      (AppStrings.termsCompanyResponsibilityTitle,
          AppStrings.termsCompanyResponsibilityBody),
      (AppStrings.termsPrivacyTitle, AppStrings.termsPrivacyBody),
      (AppStrings.termsApplicableLawTitle, AppStrings.termsApplicableLawBody),
    ];

    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(
        title: AppStrings.termsTitle,
      ),
      child: ListView.separated(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.lg.w,
          vertical: AppSpacing.lg.h,
        ),
        itemCount: sections.length,
        separatorBuilder: (_, _) => AppSpacing.xl.verticalSpace,
        itemBuilder: (context, index) {
          final (title, body) = sections[index];
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
