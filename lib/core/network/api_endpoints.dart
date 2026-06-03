class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/api/v1.0/auth/login';
  static const String refreshToken = '/api/v1/identity/tokens/refresh';

  // Users
  static const String currentUser = '/api/v1/users/me';
  static const String deleteAccount = '/api/v1/users/me';
  static const String updateFcmToken = '/api/v1/users/me/fcm-token';
  static const String updatePreferredLanguage = '/api/v1/users/me/language';

  // Maps
  static const String mapsSearch = '/api/v1/maps/search';
  static const String mapsReverseGeocode = '/api/v1/maps/reverse-geocodings';
  static const String mapsDirections = '/api/v1/maps/directions';

  // Vehicle types
  static const String vehicleTypes = '/api/v1/vehicle-types';

  // App config
  static const String clientConfig = '/api/v1/app-config/client';

  // Trips
  static const String tripQuotes = '/api/v1/trips/quotes';
  static const String requestTrip = '/api/v1/trips';
  static String tripById(String id) => '/api/v1/trips/$id';
  static String updatePassengerNote(String id) =>
      '/api/v1/trips/$id/passenger-note';
  static String cancelTrip(String id) => '/api/v1/trips/$id/cancellations';
  static String submitCompensationClaim(String id) =>
      '/api/v1/trips/$id/compensation-claims';
  static const String uploadCompensationEvidence =
      '/api/v1/uploads/compensation-evidence';
  static const String tripHistory = '/api/v1/trips';
  static const String tripCount = '/api/v1/trips/count';
  static String tripReceipt(String id) => '/api/v1/trips/$id/receipt';
  static String tripInvoice(String id) => '/api/v1/trips/$id/invoice';
  static String tripInvoicePdf(String id) => '/api/v1/trips/$id/invoice/pdf';
}

