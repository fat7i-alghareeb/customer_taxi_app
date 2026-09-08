class ApiEndpoints {
  ApiEndpoints._();

  // Auth (legacy Firebase phone session — kept only for backward compatibility)
  static const String login = '/api/v1/auth/sessions';
  static const String refreshToken = '/api/v1/auth/tokens/refreshes';

  // Auth — backend-owned OTP (CM.com SMS / Titan email) + Google
  static const String phoneLoginOtp = '/api/v1/auth/phone/login/otp';
  static const String phoneLoginOtpVerify = '/api/v1/auth/phone/login/otp/verify';
  static const String phoneSignupOtp = '/api/v1/auth/phone/signup/otp';
  static const String phoneSignupOtpVerify =
      '/api/v1/auth/phone/signup/otp/verify';
  static const String emailLoginOtp = '/api/v1/auth/email/login/otp';
  static const String emailLoginOtpVerify = '/api/v1/auth/email/login/otp/verify';
  static const String emailSignupOtp = '/api/v1/auth/email/signup/otp';
  static const String emailSignupOtpVerify =
      '/api/v1/auth/email/signup/otp/verify';
  static const String googleAuth = '/api/v1/auth/google';
  static const String registerComplete = '/api/v1/auth/register/complete';
  static const String phoneVerifyOtp = '/api/v1/auth/phone/verify/otp';
  static const String phoneVerifyOtpVerify =
      '/api/v1/auth/phone/verify/otp/verify';
  static const String accountFreshStart = '/api/v1/auth/account/fresh-start';
  static const String accountContinueExisting = '/api/v1/auth/account/continue';

  // Users
  static const String currentUser = '/api/v1/users/me';
  static const String deleteAccount = '/api/v1/users/me';
  static const String updateFcmToken = '/api/v1/users/me/fcm-token';
  static const String updatePreferredLanguage = '/api/v1/users/me/language';

  // Maps
  static const String mapsSearch = '/api/v1/maps/searches';
  static const String mapsReverseGeocode = '/api/v1/maps/reverse-geocodings';
  static const String mapsDirections = '/api/v1/maps/directions';

  // Vehicle types
  static const String vehicleTypes = '/api/v1/vehicle-types';

  // App config
  static const String clientConfig = '/api/v1/app-config/client';
  static const String supportContact = '/api/v1/app-config/support-contact';
  static const String appVersionConfig = '/api/v1/app-config/app-version';
  static const String bootstrapConfig = '/api/v1/app-config/bootstrap';

  // Trips
  static const String tripQuotes = '/api/v1/trips/quotes';
  static const String requestTrip = '/api/v1/trips';
  static const String tripActive = '/api/v1/trips/active';

  /// Every active trip the passenger holds — one live trip plus any number of
  /// future reservations. [tripActive] stays single-trip for the driver app.
  static const String tripActiveList = '/api/v1/trips/active/list';
  static String tripById(String id) => '/api/v1/trips/$id';
  static String updatePassengerNote(String id) =>
      '/api/v1/trips/$id/passenger-note';
  static String cancelTrip(String id) => '/api/v1/trips/$id/cancellations';
  static String postponeNoDriver(String id) =>
      '/api/v1/trips/$id/no-driver/postpone';
  static String noDriverCancelTrip(String id) =>
      '/api/v1/trips/$id/no-driver/cancel';
  static String submitCompensationClaim(String id) =>
      '/api/v1/trips/$id/compensation-claims';
  static String submitRefundIssue(String id) =>
      '/api/v1/trips/$id/refund-issues';
  static const String uploadCompensationEvidence =
      '/api/v1/uploads/compensation-evidence';
  static const String tripHistory = '/api/v1/trips';
  static const String tripCount = '/api/v1/trips/count';
  static String rateTrip(String id) => '/api/v1/trips/$id/rating';
  static String updateTripScheduledTime(String id) =>
      '/api/v1/trips/$id/scheduled-time';
  // Stops and passenger count go through edit/preview + edit/apply — the old per-field PUTs
  // re-priced the trip without charging the difference and have been removed server-side.
  static String updateTripBagCount(String id) => '/api/v1/trips/$id/bag-count';
  static String previewTripEdit(String id) => '/api/v1/trips/$id/edit/preview';
  static String applyTripEdit(String id) => '/api/v1/trips/$id/edit/apply';
  static String settleWaitingFee(String id) =>
      '/api/v1/trips/$id/waiting-fee/settlements';
  static String tripMessages(String id) => '/api/v1/trips/$id/messages';
  static String uploadTripRecording(String id) =>
      '/api/v1/trips/$id/recordings';
  static String tripReceipt(String id) => '/api/v1/trips/$id/receipt';
  static String tripInvoice(String id) => '/api/v1/trips/$id/invoice';
  static String tripInvoicePdf(String id) => '/api/v1/trips/$id/invoice/pdf';

  // Wallet (ride balance / Fat7i Saldo)
  static const String wallet = '/api/v1/wallet';
  static const String walletTransactions = '/api/v1/wallet/transactions';
  static const String walletTopUps = '/api/v1/wallet/top-ups';

  // Saved payment methods
  static const String paymentMethods = '/api/v1/payment-methods';
  static const String paymentMethodSetupIntents =
      '/api/v1/payment-methods/setup-intents';
  static String paymentMethodDefault(String id) =>
      '/api/v1/payment-methods/$id/default';
  static String paymentMethodById(String id) => '/api/v1/payment-methods/$id';

  // Preferred trip-booking payment method
  static const String paymentPreferences = '/api/v1/payment-preferences';
}
