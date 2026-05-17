import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_stripe_payment_model.freezed.dart';
part 'order_stripe_payment_model.g.dart';

@freezed
abstract class OrderStripePaymentModel with _$OrderStripePaymentModel {
  const factory OrderStripePaymentModel({
    required String paymentIntentId,
    required String clientSecret,
    required String publishableKey,
  }) = _OrderStripePaymentModel;

  factory OrderStripePaymentModel.fromJson(Map<String, dynamic> json) =>
      _$OrderStripePaymentModelFromJson(json);
}
