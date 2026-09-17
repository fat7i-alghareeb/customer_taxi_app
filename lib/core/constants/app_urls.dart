/// Public customertaxi web pages the app links out to.
///
/// These are the canonical, publicly-hosted documents — they must stay readable
/// without a login, because the consent checkboxes on the sign-up screen link to
/// them before the rider has an account. Keeping the legal text on the website
/// means it can be corrected without shipping an app release.
class AppUrls {
  const AppUrls._();

  static const String website = 'https://fat7i.dev/';
  static const String termsAndConditions =
      'https://fat7i.dev/algemene-voorwaarden';
  static const String privacyPolicy = 'https://fat7i.dev/privacybeleid';
}
