import '../../../../core/utils/result.dart';
import '../entities/order_entity.dart';
import '../entities/order_location_entity.dart';
import '../entities/order_location_request_entity.dart';

abstract class OrderRepository {
  Future<Result<List<OrderEntity>>> getAllOrders();

  Future<Result<List<OrderLocationEntity>>> searchLocations(
    OrderLocationSearchRequestEntity request,
  );

  Future<Result<OrderLocationEntity>> reverseGeocode(
    OrderReverseGeocodeRequestEntity request,
  );
}
