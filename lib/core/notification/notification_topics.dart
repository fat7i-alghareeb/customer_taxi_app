/// FCM topic names shared with the backend.
///
/// These strings must match TAXI_SERVER broadcast topic names.
class NotificationTopics {
  NotificationTopics._();

  /// Receives customer-facing broadcast alerts.
  static const String customers = 'customers';
}
