import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_location_entity.dart';
import '../../domain/entities/order_location_request_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../mappers/order_location_model_mapper.dart';
import '../mappers/order_model_mapper.dart';
import '../params/order_params.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl(this._remote);

  final OrderRemoteDataSource _remote;

  @override
  Future<Result<List<OrderEntity>>> getAllOrders() {
    return runAsResult(() async {
      printM('[OrderRepository] getAllOrders start');
      final models = await _remote.getAllOrders();
      printG('[OrderRepository] getAllOrders success count=${models.length}');
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<List<OrderLocationEntity>>> searchLocations(
    OrderLocationSearchRequestEntity request,
  ) {
    return runAsResult(() async {
      printM('[OrderRepository] searchLocations query="${request.query}"');
      final models = await _remote.searchLocations(
        OrderSearchLocationParams(query: request.query),
      );
      printG('[OrderRepository] searchLocations success count=${models.length}');
      return models.map((e) => e.toEntity).toList();
    });
  }

  @override
  Future<Result<OrderLocationEntity>> reverseGeocode(
    OrderReverseGeocodeRequestEntity request,
  ) {
    return runAsResult(() async {
      printM(
        '[OrderRepository] reverseGeocode lat=${request.latitude} lng=${request.longitude}',
      );
      final model = await _remote.reverseGeocode(
        OrderReverseGeocodeParams(
          latitude: request.latitude,
          longitude: request.longitude,
        ),
      );

      printG('[OrderRepository] reverseGeocode success label="${model.label}"');

      return model.toEntity;
    });
  }
}
