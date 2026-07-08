import '../../../../core/utils/result.dart';
import '../entities/payment_method_entities.dart';
import '../entities/wallet_entities.dart';

abstract class PaymentRepository {
  Future<Result<WalletBalanceEntity>> getWalletBalance();

  Future<Result<WalletTransactionsPage>> getWalletTransactions({
    required int page,
    required int pageSize,
  });

  Future<Result<WalletTopUpEntity>> createTopUp({required double amount});

  Future<Result<List<PaymentMethodEntity>>> getPaymentMethods();

  Future<Result<PaymentMethodSetupEntity>> createSetupIntent();

  Future<Result<PaymentMethodEntity>> addPaymentMethod({
    required String paymentMethodId,
    required bool setAsDefault,
  });

  Future<Result<void>> setDefaultPaymentMethod(String id);

  Future<Result<void>> deletePaymentMethod(String id);

  Future<Result<PaymentPreferenceEntity>> getPaymentPreference();

  Future<Result<void>> setPaymentPreference(String? preferredMethodType);
}
