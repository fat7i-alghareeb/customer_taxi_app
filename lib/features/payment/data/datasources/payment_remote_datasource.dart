import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/payment_method_models.dart';
import '../models/wallet_models.dart';

@lazySingleton
class PaymentRemoteDataSource {
  const PaymentRemoteDataSource(this._dio);

  final Dio _dio;

  // ── Wallet ───────────────────────────────────────────────────────────────

  Future<WalletBalanceModel> getWalletBalance() {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] getWalletBalance');
      final response = await _dio.get<dynamic>(ApiEndpoints.wallet);
      return WalletBalanceModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<WalletTransactionsPageModel> getWalletTransactions({
    required int page,
    required int pageSize,
  }) {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] getWalletTransactions page=$page');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.walletTransactions,
        queryParameters: {'page': page, 'pageSize': pageSize},
      );
      return WalletTransactionsPageModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  Future<WalletTopUpModel> createTopUp({required double amount}) {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] createTopUp amount=$amount');
      final response = await _dio.post<dynamic>(
        ApiEndpoints.walletTopUps,
        data: {'amount': amount},
      );
      return WalletTopUpModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  // ── Saved payment methods ────────────────────────────────────────────────

  Future<List<PaymentMethodModel>> getPaymentMethods() {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] getPaymentMethods');
      final response = await _dio.get<dynamic>(ApiEndpoints.paymentMethods);
      final list = (response.data as List<dynamic>)
          .map((e) => PaymentMethodModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return list;
    });
  }

  Future<PaymentMethodSetupModel> createSetupIntent() {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] createSetupIntent');
      final response = await _dio.post<dynamic>(
        ApiEndpoints.paymentMethodSetupIntents,
      );
      return PaymentMethodSetupModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  Future<PaymentMethodModel> addPaymentMethod(
    AddPaymentMethodRequestModel request,
  ) {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] addPaymentMethod');
      final response = await _dio.post<dynamic>(
        ApiEndpoints.paymentMethods,
        data: request.toJson(),
      );
      return PaymentMethodModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  Future<void> setDefaultPaymentMethod(String id) {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] setDefaultPaymentMethod id=$id');
      await _dio.put<dynamic>(ApiEndpoints.paymentMethodDefault(id));
    });
  }

  Future<void> deletePaymentMethod(String id) {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] deletePaymentMethod id=$id');
      await _dio.delete<dynamic>(ApiEndpoints.paymentMethodById(id));
    });
  }

  // ── Preferred booking method ─────────────────────────────────────────────

  Future<PaymentPreferenceModel> getPaymentPreference() {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] getPaymentPreference');
      final response = await _dio.get<dynamic>(
        ApiEndpoints.paymentPreferences,
      );
      return PaymentPreferenceModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  Future<void> setPaymentPreference(String? preferredMethodType) {
    return rethrowAsAppException(() async {
      printY('[PaymentRemoteDataSource] setPaymentPreference=$preferredMethodType');
      await _dio.put<dynamic>(
        ApiEndpoints.paymentPreferences,
        data: {'preferredMethodType': preferredMethodType},
      );
    });
  }
}
