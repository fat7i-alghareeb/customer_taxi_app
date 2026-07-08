/// Stripe payment-sheet details returned for a wallet top-up.
class StripePaymentEntity {
  const StripePaymentEntity({
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

class WalletBalanceEntity {
  const WalletBalanceEntity({
    required this.balance,
    required this.currencyCode,
  });

  final double balance;
  final String currencyCode;
}

class WalletTopUpEntity {
  const WalletTopUpEntity({
    required this.amount,
    required this.currencyCode,
    required this.stripePayment,
  });

  final double amount;
  final String currencyCode;
  final StripePaymentEntity stripePayment;
}

class WalletTransactionEntity {
  const WalletTransactionEntity({
    required this.id,
    required this.type,
    required this.direction,
    required this.amount,
    required this.currencyCode,
    required this.status,
    required this.createdAtUtc,
    this.balanceAfter,
    this.description,
    this.completedAtUtc,
  });

  final String id;

  /// Raw backend type, e.g. "TopUp", "TripPayment", "FeeCharge", "RefundReversal".
  final String type;

  /// "Credit" or "Debit".
  final String direction;

  final double amount;
  final String currencyCode;

  /// "Pending", "Committed", "Released", "Failed".
  final String status;

  final DateTime createdAtUtc;
  final double? balanceAfter;
  final String? description;
  final DateTime? completedAtUtc;

  bool get isCredit => direction.toLowerCase() == 'credit';
  bool get isPending => status.toLowerCase() == 'pending';
}

class WalletTransactionsPage {
  const WalletTransactionsPage({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
  });

  final List<WalletTransactionEntity> items;
  final int totalCount;
  final int page;
  final int pageSize;

  bool get hasMore => page * pageSize < totalCount;
}
