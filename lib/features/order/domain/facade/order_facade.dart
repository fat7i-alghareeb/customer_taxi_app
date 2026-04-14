import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/utils/result.dart';
import '../entities/order_entity.dart';
import '../entities/order_location_entity.dart';
import '../entities/order_location_request_entity.dart';
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
}
