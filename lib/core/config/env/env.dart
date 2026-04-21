import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GOOGLE_MAPS_API_KEY', obfuscate: true, defaultValue: '')
  static final String googleMapsApiKey = _Env.googleMapsApiKey;

  @EnviedField(varName: 'STAGE_BASE_URL', defaultValue: '')
  static final String stageBaseUrl = _Env.stageBaseUrl;

  @EnviedField(varName: 'PRODUCTION_BASE_URL', defaultValue: '')
  static final String productionBaseUrl = _Env.productionBaseUrl;
}
