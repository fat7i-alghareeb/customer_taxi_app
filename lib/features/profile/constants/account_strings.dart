import 'package:easy_localization/easy_localization.dart';

/// Localized strings for the Account hub. Keys live in `assets/l10n/*.json`
/// (translated for all 9 supported languages). Existing keys (logout, cancel,
/// drawer*, select*, language*, profileEditTitle, profileDeleteAccount, …) are
/// reused directly from `AppStrings`.
abstract class AccountStrings {
  static String get accountNameFallback => 'accountNameFallback'.tr();
  static String get accountVerifyPhone => 'accountVerifyPhone'.tr();
  static String get accountSectionAccount => 'accountSectionAccount'.tr();
  static String get accountSectionPreferences =>
      'accountSectionPreferences'.tr();
  static String get accountSectionSupport => 'accountSectionSupport'.tr();
  static String get accountSectionLegal => 'accountSectionLegal'.tr();
  static String get accountLogoutMessage => 'accountLogoutMessage'.tr();
  static String get accountNoAddress => 'accountNoAddress'.tr();
}
