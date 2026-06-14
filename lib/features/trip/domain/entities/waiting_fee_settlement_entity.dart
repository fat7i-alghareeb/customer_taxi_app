/// Result of requesting to settle an outstanding waiting fee. When
/// [stripePayment] is null there is nothing to pay (already settled / no fee).
class WaitingFeeSettlementEntity {
  const WaitingFeeSettlementEntity({
    required this.amount,
    required this.currencyCode,
    this.stripePayment,
  });

  final double amount;
  final String currencyCode;
  final WaitingFeeStripePaymentEntity? stripePayment;

  bool get hasOutstanding => amount > 0 && stripePayment != null;
}

class WaitingFeeStripePaymentEntity {
  const WaitingFeeStripePaymentEntity({
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
