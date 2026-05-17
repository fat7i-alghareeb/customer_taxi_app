class OrderStripePaymentEntity {
  const OrderStripePaymentEntity({
    required this.paymentIntentId,
    required this.clientSecret,
    required this.publishableKey,
  });

  final String paymentIntentId;
  final String clientSecret;
  final String publishableKey;
}
