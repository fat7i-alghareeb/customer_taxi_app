import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../entities/payment_method_entities.dart';
import '../entities/wallet_entities.dart';
import '../repositories/payment_repository.dart';

@lazySingleton
class PaymentFacade {
  const PaymentFacade(this._repository);

  final PaymentRepository _repository;

  Future<Result<WalletBalanceEntity>> getWalletBalance() =>
      _repository.getWalletBalance();

  Future<Result<WalletTransactionsPage>> getWalletTransactions({
    int page = 1,
    int pageSize = 20,
  }) => _repository.getWalletTransactions(page: page, pageSize: pageSize);

  Future<Result<WalletTopUpEntity>> createTopUp({required double amount}) =>
      _repository.createTopUp(amount: amount);

  Future<Result<List<PaymentMethodEntity>>> getPaymentMethods() =>
      _repository.getPaymentMethods();

  Future<Result<PaymentMethodSetupEntity>> createSetupIntent() =>
      _repository.createSetupIntent();

  Future<Result<PaymentMethodEntity>> addPaymentMethod({
    required String paymentMethodId,
    bool setAsDefault = false,
  }) => _repository.addPaymentMethod(
    paymentMethodId: paymentMethodId,
    setAsDefault: setAsDefault,
  );

  Future<Result<void>> setDefaultPaymentMethod(String id) =>
      _repository.setDefaultPaymentMethod(id);

  Future<Result<void>> deletePaymentMethod(String id) =>
      _repository.deletePaymentMethod(id);

  Future<Result<PaymentPreferenceEntity>> getPaymentPreference() =>
      _repository.getPaymentPreference();

  Future<Result<void>> setPaymentPreference(String? preferredMethodType) =>
      _repository.setPaymentPreference(preferredMethodType);
}
