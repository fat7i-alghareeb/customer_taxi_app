// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:customertaxi/core/injection/register_module.dart' as _i548;
import 'package:customertaxi/core/network/interceptors/custom_dio_interceptor.dart'
    as _i18;
import 'package:customertaxi/core/network/interceptors/error_interceptor.dart'
    as _i751;
import 'package:customertaxi/core/network/interceptors/localization_interceptor.dart'
    as _i341;
import 'package:customertaxi/core/network/interceptors/memory_aware_interceptor.dart'
    as _i918;
import 'package:customertaxi/core/notification/notification_coordinator.dart'
    as _i511;
import 'package:customertaxi/core/notification/notification_fcm_service.dart'
    as _i226;
import 'package:customertaxi/core/notification/notification_local_service.dart'
    as _i181;
import 'package:customertaxi/core/notification/notification_permission_service.dart'
    as _i324;
import 'package:customertaxi/core/notification/notification_timezone_service.dart'
    as _i661;
import 'package:customertaxi/core/router/router_config.dart' as _i434;
import 'package:customertaxi/core/services/localization/locale_service.dart'
    as _i504;
import 'package:customertaxi/core/services/location/location_service.dart'
    as _i396;
import 'package:customertaxi/core/services/onboarding/onboarding_service.dart'
    as _i389;
import 'package:customertaxi/core/services/permissions/location_permission_service.dart'
    as _i331;
import 'package:customertaxi/core/services/permissions/permissions_coordinator.dart'
    as _i102;
import 'package:customertaxi/core/services/session/auth_manager.dart' as _i814;
import 'package:customertaxi/core/services/session/auth_state_notifier.dart'
    as _i32;
import 'package:customertaxi/core/services/session/jwt_token_storage.dart'
    as _i247;
import 'package:customertaxi/core/services/storage/storage_service.dart' as _i742;
import 'package:customertaxi/core/theme/theme_controller.dart' as _i998;
import 'package:customertaxi/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i54;
import 'package:customertaxi/features/auth/data/repositories/auth_repository_impl.dart'
    as _i771;
import 'package:customertaxi/features/auth/domain/facade/auth_facade.dart'
    as _i239;
import 'package:customertaxi/features/auth/domain/repositories/auth_repository.dart'
    as _i618;
import 'package:customertaxi/features/auth/presentation/states/auth_bloc.dart'
    as _i781;
import 'package:customertaxi/features/root/data/datasources/root_remote_datasource.dart'
    as _i312;
import 'package:customertaxi/features/root/data/repositories/root_repository_impl.dart'
    as _i244;
import 'package:customertaxi/features/root/domain/facade/root_facade.dart'
    as _i770;
import 'package:customertaxi/features/root/domain/repositories/root_repository.dart'
    as _i549;
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart'
    as _i144;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i742.StorageService>(
      () => registerModule.storageService,
      preResolve: true,
    );
    gh.lazySingleton<_i18.CustomDioInterceptor>(
      () => _i18.CustomDioInterceptor(),
    );
    gh.lazySingleton<_i751.ErrorInterceptor>(() => _i751.ErrorInterceptor());
    gh.lazySingleton<_i918.MemoryAwareInterceptor>(
      () => _i918.MemoryAwareInterceptor(),
    );
    gh.lazySingleton<_i226.NotificationFcmService>(
      () => _i226.NotificationFcmService(),
    );
    gh.lazySingleton<_i181.NotificationLocalService>(
      () => _i181.NotificationLocalService(),
    );
    gh.lazySingleton<_i324.NotificationPermissionService>(
      () => const _i324.NotificationPermissionService(),
    );
    gh.lazySingleton<_i661.NotificationTimezoneService>(
      () => _i661.NotificationTimezoneService(),
    );
    gh.lazySingleton<_i434.AppRouteRegistry>(
      () => const _i434.AppRouteRegistry(),
    );
    gh.lazySingleton<_i396.LocationService>(
      () => const _i396.LocationService(),
    );
    gh.lazySingleton<_i331.LocationPermissionService>(
      () => const _i331.LocationPermissionService(),
    );
    gh.lazySingleton<_i32.AuthStateNotifier>(() => _i32.AuthStateNotifier());
    gh.lazySingleton<_i511.NotificationCoordinator>(
      () => _i511.NotificationCoordinator(
        gh<_i324.NotificationPermissionService>(),
        gh<_i661.NotificationTimezoneService>(),
        gh<_i181.NotificationLocalService>(),
        gh<_i226.NotificationFcmService>(),
      ),
    );
    gh.lazySingleton<_i102.PermissionsCoordinator>(
      () => _i102.PermissionsCoordinator(
        gh<_i511.NotificationCoordinator>(),
        gh<_i331.LocationPermissionService>(),
        gh<_i396.LocationService>(),
      ),
    );
    gh.lazySingleton<_i504.LocaleService>(
      () => _i504.LocaleService(gh<_i742.StorageService>()),
    );
    gh.lazySingleton<_i389.OnboardingService>(
      () => _i389.OnboardingService(gh<_i742.StorageService>()),
    );
    gh.lazySingleton<_i247.JwtTokenStorage>(
      () => _i247.JwtTokenStorage(gh<_i742.StorageService>()),
    );
    gh.lazySingleton<_i998.ThemeController>(
      () => _i998.ThemeController(gh<_i742.StorageService>()),
    );
    gh.factory<_i144.RootBloc>(
      () => _i144.RootBloc(
        gh<_i102.PermissionsCoordinator>(),
        gh<_i396.LocationService>(),
      ),
    );
    gh.lazySingleton<_i341.LocalizationInterceptor>(
      () => _i341.LocalizationInterceptor(gh<_i504.LocaleService>()),
    );
    gh.lazySingleton<_i814.AuthManager>(
      () => _i814.AuthManager(
        storage: gh<_i742.StorageService>(),
        state: gh<_i32.AuthStateNotifier>(),
        tokenStorage: gh<_i247.JwtTokenStorage>(),
      ),
    );
    gh.lazySingleton<_i434.AppRouterConfig>(
      () => _i434.AppRouterConfig(
        gh<_i32.AuthStateNotifier>(),
        gh<_i389.OnboardingService>(),
        gh<_i102.PermissionsCoordinator>(),
        gh<_i434.AppRouteRegistry>(),
      ),
    );
    gh.singleton<_i361.Dio>(
      () => registerModule.dio(
        gh<_i918.MemoryAwareInterceptor>(),
        gh<_i341.LocalizationInterceptor>(),
        gh<_i751.ErrorInterceptor>(),
        gh<_i18.CustomDioInterceptor>(),
        gh<_i814.AuthManager>(),
        gh<_i247.JwtTokenStorage>(),
      ),
    );
    gh.lazySingleton<_i54.AuthRemoteDataSource>(
      () => _i54.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i312.RootRemoteDataSource>(
      () => _i312.RootRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i618.AuthRepository>(
      () => _i771.AuthRepositoryImpl(gh<_i54.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i549.RootRepository>(
      () => _i244.RootRepositoryImpl(gh<_i312.RootRemoteDataSource>()),
    );
    gh.lazySingleton<_i239.AuthFacade>(
      () => _i239.AuthFacade(gh<_i618.AuthRepository>()),
    );
    gh.lazySingleton<_i770.RootFacade>(
      () => _i770.RootFacade(gh<_i549.RootRepository>()),
    );
    gh.factory<_i781.AuthBloc>(() => _i781.AuthBloc(gh<_i239.AuthFacade>()));
    return this;
  }
}

class _$RegisterModule extends _i548.RegisterModule {}
