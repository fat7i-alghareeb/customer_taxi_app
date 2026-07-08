import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method_models.freezed.dart';
part 'payment_method_models.g.dart';

@freezed
abstract class PaymentMethodModel with _$PaymentMethodModel {
  const factory PaymentMethodModel({
    required String id,
    required String cardBrand,
    required String lastFour,
    required int expiryMonth,
    required int expiryYear,
    String? cardholderName,
    @Default(false) bool isDefault,
  }) = _PaymentMethodModel;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
}

@freezed
abstract class PaymentMethodSetupModel with _$PaymentMethodSetupModel {
  const factory PaymentMethodSetupModel({
    required String setupIntentId,
    required String clientSecret,
    required String publishableKey,
    required String customerId,
    required String ephemeralKeySecret,
  }) = _PaymentMethodSetupModel;

  factory PaymentMethodSetupModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodSetupModelFromJson(json);
}

@freezed
abstract class PaymentPreferenceModel with _$PaymentPreferenceModel {
  const factory PaymentPreferenceModel({
    String? preferredMethodType,
    @Default(<String>[]) List<String> enabledMethodTypes,
  }) = _PaymentPreferenceModel;

  factory PaymentPreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentPreferenceModelFromJson(json);
}

/// Request body for persisting a reusable payment method after a confirmed SetupIntent.
@freezed
abstract class AddPaymentMethodRequestModel with _$AddPaymentMethodRequestModel {
  const factory AddPaymentMethodRequestModel({
    required String paymentMethodId,
    @Default(false) bool setAsDefault,
  }) = _AddPaymentMethodRequestModel;

  factory AddPaymentMethodRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddPaymentMethodRequestModelFromJson(json);
}
