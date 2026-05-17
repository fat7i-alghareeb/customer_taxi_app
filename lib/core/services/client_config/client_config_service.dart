import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../network/api_endpoints.dart';
import '../../../utils/helpers/colored_print.dart';
import 'client_config_model.dart';

@singleton
class ClientConfigService {
  ClientConfigService(this._dio);

  final Dio _dio;
  ClientConfigModel _cached = ClientConfigModel.disabled;

  ClientConfigModel get current => _cached;

  Future<void> fetch() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.clientConfig,
      );
      final data = response.data;
      if (data != null) {
        _cached = ClientConfigModel.fromJson(data);
        printG('[ClientConfigService] fetched stripeEnabled=${_cached.stripeEnabled}');
      }
    } catch (e) {
      printY('[ClientConfigService] fetch failed: $e — using defaults');
    }
  }
}
