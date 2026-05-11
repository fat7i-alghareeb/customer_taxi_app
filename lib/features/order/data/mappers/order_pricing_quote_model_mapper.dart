import 'package:customertaxi/utils/helpers/colored_print.dart';
import '../../domain/entities/order_trip_car_option_entity.dart';
import '../models/order_pricing_quote_model.dart';

extension OrderPricingQuoteModelMapper on OrderPricingQuoteModel {
  OrderTripCarOptionEntity get toEntity {
    try {
      printM('[OrderMapper] mapping quoteId=$quoteId type=$vehicleTypeName');
      final entity = OrderTripCarOptionEntity(
        quoteId: quoteId,
        typeId: vehicleTypeId,
        typeCode: vehicleTypeCode,
        name: vehicleTypeName,
        passengerCapacity: capacity,
        originalPrice: originalFare,
        price: finalFare,
        discountPercent: discountPercent,
        currency: currencyCode,
        validUntil: validUntil,
      );
      printG('[OrderMapper] mapping success');
      return entity;
    } catch (e, s) {
      printR('[OrderMapper] mapping failed: $e');
      printR('$s');
      rethrow;
    }
  }
}
