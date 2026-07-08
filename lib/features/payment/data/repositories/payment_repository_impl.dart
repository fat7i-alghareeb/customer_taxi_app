import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/payment_method_entities.dart';
import '../../domain/entities/wallet_entities.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_datasource.dart';
import '../mappers/payment_model_mappers.dart';
import '../models/payment_method_models.dart';

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  const PaymentRepositoryImpl(this._remote);

  final PaymentRemoteDataSource _remote;

  @override
  Future<Result<WalletBalanceEntity>> getWalletBalance() {
    return runAsResult(() async {
      final model = await _remote.getWalletBalance();
      return model.toEntity;
    });
  }

  @override
  Future<Result<WalletTransactionsPage>> getWalletTransactions({
    required int page,
    required int pageSize,
  }) {
    return runAsResult(() async {
      final model = await _remote.getWalletTransactions(
        page: page,
        pageSize: pageSize,
      );
      return model.toEntity;
    });
  }

  @override
  Future<Result<WalletTopUpEntity>> createTopUp({required double amount}) {
    return runAsResult(() async {
      final model = await _remote.createTopUp(amount: amount);
      return model.toEntity;
    });
  }

  @override
  Future<Result<List<PaymentMethodEntity>>> getPaymentMethods() {
    return runAsResult(() async {
      final models = await _remote.getPaymentMethods();
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<PaymentMethodSetupEntity>> createSetupIntent() {
    return runAsResult(() async {
      final model = await _remote.createSetupIntent();
      return model.toEntity;
    });
  }

  @override
  Future<Result<PaymentMethodEntity>> addPaymentMethod({
    required String paymentMethodId,
    required bool setAsDefault,
  }) {
    return runAsResult(() async {
      final model = await _remote.addPaymentMethod(
        AddPaymentMethodRequestModel(
          paymentMethodId: paymentMethodId,
          setAsDefault: setAsDefault,
        ),
      );
      return model.toEntity;
    });
  }

  @override
  Future<Result<void>> setDefaultPaymentMethod(String id) {
    return runAsResult(() => _remote.setDefaultPaymentMethod(id));
  }

  @override
  Future<Result<void>> deletePaymentMethod(String id) {
    return runAsResult(() => _remote.deletePaymentMethod(id));
  }

  @override
  Future<Result<PaymentPreferenceEntity>> getPaymentPreference() {
    return runAsResult(() async {
      final model = await _remote.getPaymentPreference();
      return model.toEntity;
    });
  }

  @override
  Future<Result<void>> setPaymentPreference(String? preferredMethodType) {
    return runAsResult(() => _remote.setPaymentPreference(preferredMethodType));
  }
}
