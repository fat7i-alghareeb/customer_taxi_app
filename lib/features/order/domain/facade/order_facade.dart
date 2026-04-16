import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/utils/result.dart';
import '../entities/order_entity.dart';
import '../entities/order_location_entity.dart';
import '../entities/order_location_request_entity.dart';
import '../entities/order_trip_car_option_entity.dart';
import '../entities/order_trip_route_entity.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class OrderFacade {
  const OrderFacade(this._repository);

  final OrderRepository _repository;

  Future<Result<List<OrderEntity>>> getAllOrders() {
    printC('[OrderFacade] getAllOrders');
    return _repository.getAllOrders();
  }

  Future<Result<List<OrderLocationEntity>>> searchLocations(
    OrderLocationSearchRequestEntity request,
  ) {
    printC('[OrderFacade] searchLocations query="${request.query}"');
    return _repository.searchLocations(request);
  }

  Future<Result<OrderLocationEntity>> reverseGeocode(
    OrderReverseGeocodeRequestEntity request,
  ) {
    printC(
      '[OrderFacade] reverseGeocode lat=${request.latitude} lng=${request.longitude}',
    );
    return _repository.reverseGeocode(request);
  }

  Future<Result<OrderTripRouteEntity>> getTripRoute(
    OrderTripRouteRequestEntity request,
  ) {
    printC(
      '[OrderFacade] getTripRoute from=(${request.fromLatitude},${request.fromLongitude}) to=(${request.toLatitude},${request.toLongitude})',
    );
    return _repository.getTripRoute(request);
  }

  Future<Result<List<OrderTripCarOptionEntity>>> getTripCarOptions(
    OrderTripPricingRequestEntity request,
  ) {
    printC(
      '[OrderFacade] getTripCarOptions from=(${request.fromLatitude},${request.fromLongitude}) to=(${request.toLatitude},${request.toLongitude})',
    );
    return _repository.getTripCarOptions(request);
  }
}
