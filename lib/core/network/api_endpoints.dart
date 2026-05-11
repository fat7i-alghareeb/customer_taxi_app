class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/api/v1.0/auth/login';
  static const String refreshToken = '/api/v1/identity/tokens/refresh';

  // Users
  static const String currentUser = '/api/v1/users/me';

  // Maps
  static const String mapsSearch = '/api/v1/maps/search';
  static const String mapsReverseGeocode = '/api/v1/maps/reverse-geocodings';
  static const String mapsDirections = '/api/v1/maps/directions';

  // Vehicle types
  static const String vehicleTypes = '/api/v1/vehicle-types';

  // Trips
  static const String tripQuotes = '/api/v1/trips/quotes';
  static const String requestTrip = '/api/v1/trips';
  static String tripById(String id) => '/api/v1/trips/$id';
  static String cancelTrip(String id) => '/api/v1/trips/$id/cancellations';
  static const String tripHistory = '/api/v1/trips';
  static const String tripCount = '/api/v1/trips/count';
}

