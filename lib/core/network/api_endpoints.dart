class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/api/v1/auth/sessions';
  static const String refreshToken = '/api/v1/auth/tokens/refreshes';

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

  // Trips
  static const String tripQuotes = '/api/v1/trips/quotes';
  static const String requestTrip = '/api/v1/trips';
  static const String tripActive = '/api/v1/trips/active';
  static String tripById(String id) => '/api/v1/trips/$id';
  static String updatePassengerNote(String id) =>
      '/api/v1/trips/$id/passenger-note';
  static String cancelTrip(String id) => '/api/v1/trips/$id/cancellations';
  static String submitCompensationClaim(String id) =>
      '/api/v1/trips/$id/compensation-claims';
  static String submitRefundIssue(String id) =>
      '/api/v1/trips/$id/refund-issues';
  static const String uploadCompensationEvidence =
      '/api/v1/uploads/compensation-evidence';
  static const String tripHistory = '/api/v1/trips';
  static const String tripCount = '/api/v1/trips/count';
  static String rateTrip(String id) => '/api/v1/trips/$id/rating';
  static String settleWaitingFee(String id) =>
      '/api/v1/trips/$id/waiting-fee/settlements';
  static String tripMessages(String id) => '/api/v1/trips/$id/messages';
  static String uploadTripRecording(String id) =>
      '/api/v1/trips/$id/recordings';
  static String tripReceipt(String id) => '/api/v1/trips/$id/receipt';
  static String tripInvoice(String id) => '/api/v1/trips/$id/invoice';
  static String tripInvoicePdf(String id) => '/api/v1/trips/$id/invoice/pdf';
}
