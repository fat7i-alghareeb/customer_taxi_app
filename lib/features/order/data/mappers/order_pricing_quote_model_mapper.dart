import '../../domain/entities/order_trip_car_option_entity.dart';
import '../models/order_pricing_quote_model.dart';

extension OrderPricingQuoteModelMapper on OrderPricingQuoteModel {
  OrderTripCarOptionEntity get toEntity {
    return OrderTripCarOptionEntity(
      quoteId: quoteId,
      typeId: vehicleTypeId,
      typeCode: vehicleTypeCode,
      name: vehicleTypeName,
      price: finalFare,
      currency: currencyCode,
      validUntil: validUntil,
    );
  }
}
