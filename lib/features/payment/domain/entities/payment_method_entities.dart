class PaymentMethodEntity {
  const PaymentMethodEntity({
    required this.id,
    required this.cardBrand,
    required this.lastFour,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isDefault,
    this.cardholderName,
  });

  final String id;
  final String cardBrand;
  final String lastFour;
  final int expiryMonth;
  final int expiryYear;
  final bool isDefault;
  final String? cardholderName;

  String get expiryLabel =>
      '${expiryMonth.toString().padLeft(2, '0')}/${(expiryYear % 100).toString().padLeft(2, '0')}';
}

/// Stripe payment-sheet (setup mode) details for saving a reusable method.
class PaymentMethodSetupEntity {
  const PaymentMethodSetupEntity({
    required this.setupIntentId,
    required this.clientSecret,
    required this.publishableKey,
    required this.customerId,
    required this.ephemeralKeySecret,
  });

  final String setupIntentId;
  final String clientSecret;
  final String publishableKey;
  final String customerId;
  final String ephemeralKeySecret;
}

class PaymentPreferenceEntity {
  const PaymentPreferenceEntity({
    required this.preferredMethodType,
    required this.enabledMethodTypes,
  });

  final String? preferredMethodType;
  final List<String> enabledMethodTypes;
}
