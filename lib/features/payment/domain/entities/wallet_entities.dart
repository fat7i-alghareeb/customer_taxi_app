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

/// The customer's ride balance. [balance] goes NEGATIVE when a fee could not be collected —
/// a waiting fee is incurred by the customer and cannot be declined, so rather than losing it
/// the platform carries it as debt against the wallet.
class WalletBalanceEntity {
  const WalletBalanceEntity({
    required this.balance,
    required this.currencyCode,
    this.amountOwed = 0,
    this.isBookingBlocked = false,
  });

  final double balance;
  final String currencyCode;

  /// The debt as a positive figure, so the UI can say "you owe X" without juggling signs.
  final double amountOwed;

  /// Whether this debt actually stops the customer booking. Comes from the server rather than
  /// being derived from [amountOwed]: debts too small for Stripe to charge are carried but do
  /// not block, and duplicating that rule here would drift.
  final bool isBookingBlocked;

  bool get isInDebt => amountOwed > 0;
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
