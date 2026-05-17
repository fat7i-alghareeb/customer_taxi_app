import '../../domain/entities/order_stripe_payment_entity.dart';
import '../models/order_stripe_payment_model.dart';

extension OrderStripePaymentModelMapper on OrderStripePaymentModel {
  OrderStripePaymentEntity get toEntity {
    return OrderStripePaymentEntity(
      paymentIntentId: paymentIntentId,
      clientSecret: clientSecret,
      publishableKey: publishableKey,
    );
  }
}
