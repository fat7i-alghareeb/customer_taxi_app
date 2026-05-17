import '../../../../core/utils/result.dart';
import '../entities/order_location_entity.dart';
import '../entities/order_location_request_entity.dart';
import '../entities/order_saved_location_entity.dart';
import '../entities/order_trip_car_option_entity.dart';
import '../entities/order_trip_response_entity.dart';
import '../entities/order_trip_route_entity.dart';

abstract class OrderRepository {
  Future<Result<List<OrderLocationEntity>>> searchLocations(
    OrderLocationSearchRequestEntity request,
  );

  Future<Result<OrderLocationEntity>> reverseGeocode(
    OrderReverseGeocodeRequestEntity request,
  );

  Future<Result<OrderTripRouteEntity>> getTripRoute(
    OrderTripRouteRequestEntity request,
  );

  Future<Result<List<OrderTripCarOptionEntity>>> getPricingQuotes(
    OrderPricingQuotesRequestEntity request,
  );

  Future<Result<OrderTripResponseEntity>> requestTrip(
    OrderRequestTripEntity request,
  );

  Future<Result<List<OrderSavedLocationEntity>>> getSavedLocations();

  Future<Result<List<OrderSavedLocationEntity>>> saveSelectedLocation(
    OrderLocationEntity location,
  );

  Future<Result<List<OrderSavedLocationEntity>>> togglePinnedLocation(
    OrderLocationEntity location,
  );
 
  Future<Result<List<OrderSavedLocationEntity>>> removeSavedLocation(String identityKey);
 
  Future<Result<int>> getTripCount();
}
