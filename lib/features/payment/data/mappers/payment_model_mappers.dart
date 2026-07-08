import '../../domain/entities/payment_method_entities.dart';
import '../../domain/entities/wallet_entities.dart';
import '../models/payment_method_models.dart';
import '../models/wallet_models.dart';

extension StripePaymentModelMapper on StripePaymentModel {
  StripePaymentEntity get toEntity => StripePaymentEntity(
    paymentIntentId: paymentIntentId,
    clientSecret: clientSecret,
    publishableKey: publishableKey,
    customerId: customerId,
    ephemeralKeySecret: ephemeralKeySecret,
  );
}

extension WalletBalanceModelMapper on WalletBalanceModel {
  WalletBalanceEntity get toEntity =>
      WalletBalanceEntity(balance: balance, currencyCode: currencyCode);
}

extension WalletTopUpModelMapper on WalletTopUpModel {
  WalletTopUpEntity get toEntity => WalletTopUpEntity(
    amount: amount,
    currencyCode: currencyCode,
    stripePayment: stripePayment.toEntity,
  );
}

extension WalletTransactionModelMapper on WalletTransactionModel {
  WalletTransactionEntity get toEntity => WalletTransactionEntity(
    id: id,
    type: type,
    direction: direction,
    amount: amount,
    currencyCode: currencyCode,
    status: status,
    createdAtUtc: createdAtUtc,
    balanceAfter: balanceAfter,
    description: description,
    completedAtUtc: completedAtUtc,
  );
}

extension WalletTransactionsPageModelMapper on WalletTransactionsPageModel {
  WalletTransactionsPage get toEntity => WalletTransactionsPage(
    items: items.map((e) => e.toEntity).toList(),
    totalCount: totalCount,
    page: page,
    pageSize: pageSize,
  );
}

extension PaymentMethodModelMapper on PaymentMethodModel {
  PaymentMethodEntity get toEntity => PaymentMethodEntity(
    id: id,
    cardBrand: cardBrand,
    lastFour: lastFour,
    expiryMonth: expiryMonth,
    expiryYear: expiryYear,
    isDefault: isDefault,
    cardholderName: cardholderName,
  );
}

extension PaymentMethodSetupModelMapper on PaymentMethodSetupModel {
  PaymentMethodSetupEntity get toEntity => PaymentMethodSetupEntity(
    setupIntentId: setupIntentId,
    clientSecret: clientSecret,
    publishableKey: publishableKey,
    customerId: customerId,
    ephemeralKeySecret: ephemeralKeySecret,
  );
}

extension PaymentPreferenceModelMapper on PaymentPreferenceModel {
  PaymentPreferenceEntity get toEntity => PaymentPreferenceEntity(
    preferredMethodType: preferredMethodType,
    enabledMethodTypes: enabledMethodTypes,
  );
}
