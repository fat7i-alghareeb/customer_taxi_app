import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/core/constants/app_urls.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/policy_web_view_screen.dart';

/// The terms of service, loaded from the public website.
///
/// Kept as its own screen (rather than routing straight to
/// [PolicyWebViewScreen]) so the existing `/terms-and-conditions` route and
/// every `pushNamed` call site keep working untouched.
class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  static const String pagePath = '/terms-and-conditions';
  static const String pageName = 'TermsAndConditionsScreen';

  @override
  Widget build(BuildContext context) {
    return PolicyWebViewScreen(
      title: AppStrings.termsTitle,
      url: AppUrls.termsAndConditions,
    );
  }

  // Previous implementation: the full terms rendered natively from 22 pairs of
  // localization keys (`termsGeneralTitle`/`termsGeneralBody`, …). Superseded by
  // the hosted page above so legal copy can be corrected without an app release
  // and nine translations. The keys are still present in assets/l10n/*.json.
  //
  // @override
  // Widget build(BuildContext context) {
  //   final sections = <(String, String)>[
  //     (AppStrings.termsGeneralTitle, AppStrings.termsGeneralBody),
  //     (AppStrings.termsDefinitionsTitle, AppStrings.termsDefinitionsBody),
  //     (AppStrings.termsAccountTitle, AppStrings.termsAccountBody),
  //     (AppStrings.termsAppUseTitle, AppStrings.termsAppUseBody),
  //     (AppStrings.termsBookingsTitle, AppStrings.termsBookingsBody),
  //     (AppStrings.termsPricingPaymentTitle,
  //         AppStrings.termsPricingPaymentBody),
  //     (AppStrings.termsCancellationRefundsTitle,
  //         AppStrings.termsCancellationRefundsBody),
  //     (AppStrings.termsWaitingTimesTitle, AppStrings.termsWaitingTimesBody),
  //     (AppStrings.termsExecutionTitle, AppStrings.termsExecutionBody),
  //     (AppStrings.termsDelaysCompensationTitle,
  //         AppStrings.termsDelaysCompensationBody),
  //     (AppStrings.termsForceMajeureTitle, AppStrings.termsForceMajeureBody),
  //     (AppStrings.termsPassengerResponsibilitiesTitle,
  //         AppStrings.termsPassengerResponsibilitiesBody),
  //     (AppStrings.termsSmokingAlcoholTitle,
  //         AppStrings.termsSmokingAlcoholBody),
  //     (AppStrings.termsVehicleUseTitle, AppStrings.termsVehicleUseBody),
  //     (AppStrings.termsDamageCleaningTitle,
  //         AppStrings.termsDamageCleaningBody),
  //     (AppStrings.termsLuggageChildrenPetsTitle,
  //         AppStrings.termsLuggageChildrenPetsBody),
  //     (AppStrings.termsLostPropertyTitle, AppStrings.termsLostPropertyBody),
  //     (AppStrings.termsComplaintsTitle, AppStrings.termsComplaintsBody),
  //     (AppStrings.termsAccountTerminationTitle,
  //         AppStrings.termsAccountTerminationBody),
  //     (AppStrings.termsIntellectualPropertyTitle,
  //         AppStrings.termsIntellectualPropertyBody),
  //     (AppStrings.termsChangesTitle, AppStrings.termsChangesBody),
  //     (AppStrings.termsApplicableLawTitle, AppStrings.termsApplicableLawBody),
  //   ];
  //
  //   return AppScaffold.appBar(
  //     appBarConfig: AppScaffoldAppBarConfig(
  //       title: AppStrings.termsTitle,
  //     ),
  //     child: ListView.separated(
  //       padding: REdgeInsets.symmetric(
  //         horizontal: AppSpacing.lg.w,
  //         vertical: AppSpacing.lg.h,
  //       ),
  //       itemCount: sections.length + 1,
  //       separatorBuilder: (_, _) => AppSpacing.xl.verticalSpace,
  //       itemBuilder: (context, index) {
  //         if (index == 0) {
  //           return Text(
  //             AppStrings.termsEffectiveDate,
  //             style: AppTextStyles.s14w400.copyWith(
  //               color: context.onSurfaceVariant,
  //               height: 1.55,
  //             ),
  //           ).animate().fadeIn(duration: AppDurations.normal);
  //         }
  //         final (title, body) = sections[index - 1];
  //         return PolicySection(
  //           title: title,
  //           body: body,
  //           index: index,
  //         );
  //       },
  //     ),
  //   );
  // }
}
