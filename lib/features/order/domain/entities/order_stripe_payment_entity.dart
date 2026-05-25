class OrderStripePaymentEntity {
  const OrderStripePaymentEntity({
    required this.paymentIntentId,
    required this.clientSecret,
    required this.publishableKey,
    required this.customerId,
    required this.ephemeralKeySecret,
  });

  final String paymentIntentId;
  final String clientSecret;
  final String publishableKey;
  final String customerId;
  final String ephemeralKeySecret;
}
