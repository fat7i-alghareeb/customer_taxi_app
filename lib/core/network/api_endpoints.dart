class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String sendOtp = '/api/v1/auth/send-otp';
  static const String verifyOtp = '/api/v1/auth/verify-otp';
  static const String refreshToken = '/api/v1/auth/refresh';

  // Users
  static const String currentUser = '/api/v1/users/me';
  static const String uploadPhoto = '/api/v1/users/me/photo';

  // Maps
  static const String mapsSearch = '/api/v1/maps/search';
  static const String mapsReverseGeocode = '/api/v1/maps/reverse-geocode';
  static const String mapsDirections = '/api/v1/maps/directions';

  // Vehicle types
  static const String vehicleTypes = '/api/v1/vehicle-types';

  // Trips
  static const String tripQuotes = '/api/v1/trips/quotes';
  static const String requestTrip = '/api/v1/trips/request';
  static String tripById(String id) => '/api/v1/trips/$id';
  static String cancelTrip(String id) => '/api/v1/trips/$id/cancel';
  static const String tripHistory = '/api/v1/trips';
}
