import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_pricing_quote_model.freezed.dart';
part 'order_pricing_quote_model.g.dart';

@freezed
abstract class OrderPricingQuoteModel with _$OrderPricingQuoteModel {
  const factory OrderPricingQuoteModel({
    required String quoteId,
    required String vehicleTypeId,
    String? vehicleTypeCode,
    required String vehicleTypeName,
    @Default(0) int capacity,
    required double totalDistanceKm,
    required double totalDurationMin,
    @Default(0.0) double originalFare,
    required double finalFare,
    @Default(0.0) double discountPercent,
    required String currencyCode,
    required DateTime validUntil,
  }) = _OrderPricingQuoteModel;

  factory OrderPricingQuoteModel.fromJson(Map<String, dynamic> json) =>
      _$OrderPricingQuoteModelFromJson(json);
}
