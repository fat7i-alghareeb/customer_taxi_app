// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StripePaymentModel _$StripePaymentModelFromJson(Map<String, dynamic> json) =>
    _StripePaymentModel(
      paymentIntentId: json['paymentIntentId'] as String,
      clientSecret: json['clientSecret'] as String,
      publishableKey: json['publishableKey'] as String,
      customerId: json['customerId'] as String,
      ephemeralKeySecret: json['ephemeralKeySecret'] as String,
    );

Map<String, dynamic> _$StripePaymentModelToJson(_StripePaymentModel instance) =>
    <String, dynamic>{
      'paymentIntentId': instance.paymentIntentId,
      'clientSecret': instance.clientSecret,
      'publishableKey': instance.publishableKey,
      'customerId': instance.customerId,
      'ephemeralKeySecret': instance.ephemeralKeySecret,
    };

_WalletBalanceModel _$WalletBalanceModelFromJson(Map<String, dynamic> json) =>
    _WalletBalanceModel(
      balance: (json['balance'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
    );

Map<String, dynamic> _$WalletBalanceModelToJson(_WalletBalanceModel instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'currencyCode': instance.currencyCode,
    };

_WalletTopUpModel _$WalletTopUpModelFromJson(Map<String, dynamic> json) =>
    _WalletTopUpModel(
      amount: (json['amount'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
      stripePayment: StripePaymentModel.fromJson(
        json['stripePayment'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WalletTopUpModelToJson(_WalletTopUpModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currencyCode': instance.currencyCode,
      'stripePayment': instance.stripePayment,
    };

_WalletTransactionModel _$WalletTransactionModelFromJson(
  Map<String, dynamic> json,
) => _WalletTransactionModel(
  id: json['id'] as String,
  type: json['type'] as String,
  direction: json['direction'] as String,
  amount: (json['amount'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String,
  balanceAfter: (json['balanceAfter'] as num?)?.toDouble(),
  status: json['status'] as String,
  description: json['description'] as String?,
  createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
  completedAtUtc: json['completedAtUtc'] == null
      ? null
      : DateTime.parse(json['completedAtUtc'] as String),
);

Map<String, dynamic> _$WalletTransactionModelToJson(
  _WalletTransactionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'direction': instance.direction,
  'amount': instance.amount,
  'currencyCode': instance.currencyCode,
  'balanceAfter': instance.balanceAfter,
  'status': instance.status,
  'description': instance.description,
  'createdAtUtc': instance.createdAtUtc.toIso8601String(),
  'completedAtUtc': instance.completedAtUtc?.toIso8601String(),
};

_WalletTransactionsPageModel _$WalletTransactionsPageModelFromJson(
  Map<String, dynamic> json,
) => _WalletTransactionsPageModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => WalletTransactionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <WalletTransactionModel>[],
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
);

Map<String, dynamic> _$WalletTransactionsPageModelToJson(
  _WalletTransactionsPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
