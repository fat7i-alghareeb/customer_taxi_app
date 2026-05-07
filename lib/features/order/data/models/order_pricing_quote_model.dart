import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_pricing_quote_model.freezed.dart';
part 'order_pricing_quote_model.g.dart';

@freezed
abstract class OrderPricingQuoteModel with _$OrderPricingQuoteModel {
  const factory OrderPricingQuoteModel({
    required String quoteId,
    required String vehicleTypeId,
    required String vehicleTypeCode,
    required String vehicleTypeName,
    required double totalDistanceKm,
    required int totalDurationMin,
    required double finalFare,
    required String currencyCode,
    required DateTime validUntil,
  }) = _OrderPricingQuoteModel;

  factory OrderPricingQuoteModel.fromJson(Map<String, dynamic> json) =>
      _$OrderPricingQuoteModelFromJson(json);
}
