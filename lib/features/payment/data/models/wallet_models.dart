import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_models.freezed.dart';
part 'wallet_models.g.dart';

@freezed
abstract class StripePaymentModel with _$StripePaymentModel {
  const factory StripePaymentModel({
    required String paymentIntentId,
    required String clientSecret,
    required String publishableKey,
    required String customerId,
    required String ephemeralKeySecret,
  }) = _StripePaymentModel;

  factory StripePaymentModel.fromJson(Map<String, dynamic> json) =>
      _$StripePaymentModelFromJson(json);
}

@freezed
abstract class WalletBalanceModel with _$WalletBalanceModel {
  const factory WalletBalanceModel({
    required double balance,
    required String currencyCode,
  }) = _WalletBalanceModel;

  factory WalletBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceModelFromJson(json);
}

@freezed
abstract class WalletTopUpModel with _$WalletTopUpModel {
  const factory WalletTopUpModel({
    required double amount,
    required String currencyCode,
    required StripePaymentModel stripePayment,
  }) = _WalletTopUpModel;

  factory WalletTopUpModel.fromJson(Map<String, dynamic> json) =>
      _$WalletTopUpModelFromJson(json);
}

@freezed
abstract class WalletTransactionModel with _$WalletTransactionModel {
  const factory WalletTransactionModel({
    required String id,
    required String type,
    required String direction,
    required double amount,
    required String currencyCode,
    double? balanceAfter,
    required String status,
    String? description,
    required DateTime createdAtUtc,
    DateTime? completedAtUtc,
  }) = _WalletTransactionModel;

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionModelFromJson(json);
}

@freezed
abstract class WalletTransactionsPageModel with _$WalletTransactionsPageModel {
  const factory WalletTransactionsPageModel({
    @Default(<WalletTransactionModel>[]) List<WalletTransactionModel> items,
    @Default(0) int totalCount,
    @Default(1) int page,
    @Default(20) int pageSize,
  }) = _WalletTransactionsPageModel;

  factory WalletTransactionsPageModel.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionsPageModelFromJson(json);
}
