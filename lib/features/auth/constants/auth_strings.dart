import 'package:easy_localization/easy_localization.dart';

/// Localized strings for the new auth flow. Keys live in `assets/l10n/*.json`.
/// NOTE: values currently ship as English in every locale — translations are a
/// documented manual follow-up.
abstract class AuthStrings {
  static String get authLogIn => 'authLogIn'.tr();
  static String get authSignUp => 'authSignUp'.tr();
  static String get authWelcome => 'authWelcome'.tr();
  static String get authChooseMethod => 'authChooseMethod'.tr();
  static String get authContinueWithPhone => 'authContinueWithPhone'.tr();
  static String get authContinueWithEmail => 'authContinueWithEmail'.tr();
  static String get authContinueWithGoogle => 'authContinueWithGoogle'.tr();
  static String get authEmail => 'authEmail'.tr();
  static String get authEnterEmail => 'authEnterEmail'.tr();
  static String get authContinue => 'authContinue'.tr();
  static String get authName => 'authName'.tr();
  static String get authEnterName => 'authEnterName'.tr();
  static String get authNameStepTitle => 'authNameStepTitle'.tr();
  static String get authAddPhone => 'authAddPhone'.tr();
  static String get authFinishSignup => 'authFinishSignup'.tr();
  static String get authVerifyNow => 'authVerifyNow'.tr();
  static String get authSkipForNow => 'authSkipForNow'.tr();
  static String get authResendCode => 'authResendCode'.tr();
  static String get authOtpSentPhone => 'authOtpSentPhone'.tr();
  static String get authOtpSentEmail => 'authOtpSentEmail'.tr();
  static String get authNoAccountTitle => 'authNoAccountTitle'.tr();
  static String get authCreateAccount => 'authCreateAccount'.tr();
  static String get authAlreadyHaveAccount => 'authAlreadyHaveAccount'.tr();
  static String get authPhoneUnverifiedWarning =>
      'authPhoneUnverifiedWarning'.tr();
  static String get authPhoneUnverifiedInline =>
      'authPhoneUnverifiedInline'.tr();
  static String get authVerifyYourPhone => 'authVerifyYourPhone'.tr();
  static String get authPhoneVerified => 'authPhoneVerified'.tr();
  static String get authSignInCancelled => 'authSignInCancelled'.tr();
  static String get authWelcomeBack => 'authWelcomeBack'.tr();
  static String get authRegistrationSubtitle => 'authRegistrationSubtitle'.tr();
  static String get authExistingAccountBody => 'authExistingAccountBody'.tr();
  static String get authStartFresh => 'authStartFresh'.tr();
}
