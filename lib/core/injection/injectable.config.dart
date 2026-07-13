// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
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
import 'package:customertaxi/core/services/client_config/client_config_service.dart'
    as _i768;
import 'package:customertaxi/core/services/file_download/file_download_service.dart'
    as _i130;
import 'package:customertaxi/core/services/file_download/file_download_service_impl.dart'
    as _i958;
import 'package:customertaxi/core/services/localization/locale_service.dart'
    as _i504;
import 'package:customertaxi/core/services/location/location_service.dart'
    as _i396;
import 'package:customertaxi/core/services/location/startup_map_warmup_coordinator.dart'
    as _i371;
import 'package:customertaxi/core/services/objectbox/objectbox_service.dart'
    as _i477;
import 'package:customertaxi/core/services/onboarding/onboarding_service.dart'
    as _i389;
import 'package:customertaxi/core/services/permissions/location_permission_service.dart'
    as _i331;
import 'package:customertaxi/core/services/permissions/permissions_coordinator.dart'
    as _i102;
import 'package:customertaxi/core/services/realtime/realtime_lifecycle_coordinator.dart'
    as _i1032;
import 'package:customertaxi/core/services/realtime/realtime_service.dart'
    as _i404;
import 'package:customertaxi/core/services/realtime/signalr_realtime_service.dart'
    as _i856;
import 'package:customertaxi/core/services/session/auth_manager.dart' as _i814;
import 'package:customertaxi/core/services/session/auth_state_notifier.dart'
    as _i32;
import 'package:customertaxi/core/services/session/jwt_token_storage.dart'
    as _i247;
import 'package:customertaxi/core/services/storage/storage_service.dart' as _i742;
import 'package:customertaxi/core/services/support_contact/support_contact_service.dart'
    as _i384;
import 'package:customertaxi/core/theme/theme_controller.dart' as _i998;
import 'package:customertaxi/features/auth/data/datasources/auth_firebase_datasource.dart'
    as _i243;
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
import 'package:customertaxi/features/auth/presentation/states/phone_verification_cubit.dart'
    as _i404;
import 'package:customertaxi/features/chat/data/datasources/chat_remote_datasource.dart'
    as _i754;
import 'package:customertaxi/features/chat/data/repositories/chat_repository_impl.dart'
    as _i187;
import 'package:customertaxi/features/chat/domain/repositories/chat_repository.dart'
    as _i698;
import 'package:customertaxi/features/chat/presentation/states/chat_bloc.dart'
    as _i174;
import 'package:customertaxi/features/favorites/presentation/states/favorites_bloc.dart'
    as _i499;
import 'package:customertaxi/features/order/data/datasources/order_local_datasource.dart'
    as _i588;
import 'package:customertaxi/features/order/data/datasources/order_remote_datasource.dart'
    as _i93;
import 'package:customertaxi/features/order/data/repositories/order_repository_impl.dart'
    as _i312;
import 'package:customertaxi/features/order/domain/facade/order_facade.dart'
    as _i925;
import 'package:customertaxi/features/order/domain/repositories/order_repository.dart'
    as _i153;
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart'
    as _i47;
import 'package:customertaxi/features/payment/data/datasources/payment_remote_datasource.dart'
    as _i935;
import 'package:customertaxi/features/payment/data/repositories/payment_repository_impl.dart'
    as _i770;
import 'package:customertaxi/features/payment/domain/facade/payment_facade.dart'
    as _i561;
import 'package:customertaxi/features/payment/domain/repositories/payment_repository.dart'
    as _i951;
import 'package:customertaxi/features/payment/presentation/states/payment_bloc.dart'
    as _i792;
import 'package:customertaxi/features/profile/data/datasources/profile_remote_datasource.dart'
    as _i1044;
import 'package:customertaxi/features/profile/data/repositories/profile_repository_impl.dart'
    as _i411;
import 'package:customertaxi/features/profile/domain/facade/profile_facade.dart'
    as _i501;
import 'package:customertaxi/features/profile/domain/repositories/profile_repository.dart'
    as _i482;
import 'package:customertaxi/features/profile/presentation/states/profile_bloc.dart'
    as _i951;
import 'package:customertaxi/features/refund_issues/data/datasources/refund_issue_remote_datasource.dart'
    as _i863;
import 'package:customertaxi/features/refund_issues/data/repositories/refund_issue_repository_impl.dart'
    as _i217;
import 'package:customertaxi/features/refund_issues/domain/facade/refund_issue_facade.dart'
    as _i264;
import 'package:customertaxi/features/refund_issues/domain/repositories/refund_issue_repository.dart'
    as _i411;
import 'package:customertaxi/features/refund_issues/presentation/states/refund_issue_bloc.dart'
    as _i62;
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
import 'package:customertaxi/features/trip/data/datasources/trip_remote_datasource.dart'
    as _i379;
import 'package:customertaxi/features/trip/data/repositories/trip_repository_impl.dart'
    as _i384;
import 'package:customertaxi/features/trip/domain/facade/trip_facade.dart'
    as _i224;
import 'package:customertaxi/features/trip/domain/repositories/trip_repository.dart'
    as _i133;
import 'package:customertaxi/features/trip/presentation/coordinators/trip_completion_coordinator.dart'
    as _i888;
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart'
    as _i5;
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart'
    as _i753;
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
    await gh.factoryAsync<_i477.ObjectBoxService>(
      () => registerModule.objectBoxService,
      preResolve: true,
    );
    gh.singleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.singleton<_i892.FirebaseMessaging>(
      () => registerModule.firebaseMessaging,
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
    gh.lazySingleton<_i371.StartupMapWarmupCoordinator>(
      () => _i371.StartupMapWarmupCoordinator(),
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
    gh.lazySingleton<_i130.FileDownloadService>(
      () => _i958.FileDownloadServiceImpl(),
    );
    gh.lazySingleton<_i102.PermissionsCoordinator>(
      () => _i102.PermissionsCoordinator(
        gh<_i511.NotificationCoordinator>(),
        gh<_i331.LocationPermissionService>(),
        gh<_i396.LocationService>(),
      ),
    );
    gh.lazySingleton<_i243.AuthFirebaseDataSource>(
      () => _i243.AuthFirebaseDataSource(
        gh<_i59.FirebaseAuth>(),
        gh<_i892.FirebaseMessaging>(),
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
    gh.lazySingleton<_i588.OrderLocalDataSource>(
      () => _i588.OrderLocalDataSource(gh<_i477.ObjectBoxService>()),
    );
    gh.lazySingleton<_i341.LocalizationInterceptor>(
      () => _i341.LocalizationInterceptor(gh<_i504.LocaleService>()),
    );
    gh.lazySingleton<_i404.RealtimeService>(
      () => _i856.SignalRRealtimeService(gh<_i247.JwtTokenStorage>()),
    );
    gh.lazySingleton<_i814.AuthManager>(
      () => _i814.AuthManager(
        storage: gh<_i742.StorageService>(),
        state: gh<_i32.AuthStateNotifier>(),
        tokenStorage: gh<_i247.JwtTokenStorage>(),
        objectBoxService: gh<_i477.ObjectBoxService>(),
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
    gh.singleton<_i768.ClientConfigService>(
      () => _i768.ClientConfigService(gh<_i361.Dio>()),
    );
    gh.singleton<_i384.SupportContactService>(
      () => _i384.SupportContactService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i54.AuthRemoteDataSource>(
      () => _i54.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i754.ChatRemoteDataSource>(
      () => _i754.ChatRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i93.OrderRemoteDataSource>(
      () => _i93.OrderRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i935.PaymentRemoteDataSource>(
      () => _i935.PaymentRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1044.ProfileRemoteDataSource>(
      () => _i1044.ProfileRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i863.RefundIssueRemoteDataSource>(
      () => _i863.RefundIssueRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i312.RootRemoteDataSource>(
      () => _i312.RootRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i379.TripRemoteDataSource>(
      () => _i379.TripRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i482.ProfileRepository>(
      () => _i411.ProfileRepositoryImpl(gh<_i1044.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i698.ChatRepository>(
      () => _i187.ChatRepositoryImpl(gh<_i754.ChatRemoteDataSource>()),
    );
    gh.lazySingleton<_i133.TripRepository>(
      () => _i384.TripRepositoryImpl(gh<_i379.TripRemoteDataSource>()),
    );
    gh.lazySingleton<_i434.AppRouterConfig>(
      () => _i434.AppRouterConfig(
        gh<_i32.AuthStateNotifier>(),
        gh<_i389.OnboardingService>(),
        gh<_i102.PermissionsCoordinator>(),
        gh<_i371.StartupMapWarmupCoordinator>(),
        gh<_i434.AppRouteRegistry>(),
      ),
    );
    gh.lazySingleton<_i224.TripFacade>(
      () => _i224.TripFacade(gh<_i133.TripRepository>()),
    );
    gh.lazySingleton<_i549.RootRepository>(
      () => _i244.RootRepositoryImpl(gh<_i312.RootRemoteDataSource>()),
    );
    gh.factory<_i753.TripBloc>(
      () => _i753.TripBloc(gh<_i224.TripFacade>(), gh<_i404.RealtimeService>()),
    );
    gh.lazySingleton<_i888.TripCompletionCoordinator>(
      () => _i888.TripCompletionCoordinator(
        gh<_i404.RealtimeService>(),
        gh<_i434.AppRouterConfig>(),
        gh<_i224.TripFacade>(),
      ),
    );
    gh.lazySingleton<_i1032.RealtimeLifecycleCoordinator>(
      () => _i1032.RealtimeLifecycleCoordinator(
        gh<_i404.RealtimeService>(),
        gh<_i814.AuthManager>(),
        gh<_i768.ClientConfigService>(),
      ),
    );
    gh.lazySingleton<_i951.PaymentRepository>(
      () => _i770.PaymentRepositoryImpl(gh<_i935.PaymentRemoteDataSource>()),
    );
    gh.lazySingleton<_i618.AuthRepository>(
      () => _i771.AuthRepositoryImpl(
        gh<_i243.AuthFirebaseDataSource>(),
        gh<_i54.AuthRemoteDataSource>(),
        gh<_i814.AuthManager>(),
      ),
    );
    gh.lazySingleton<_i411.RefundIssueRepository>(
      () => _i217.RefundIssueRepositoryImpl(
        gh<_i863.RefundIssueRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i153.OrderRepository>(
      () => _i312.OrderRepositoryImpl(
        gh<_i93.OrderRemoteDataSource>(),
        gh<_i588.OrderLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i5.ActiveTripCubit>(
      () => _i5.ActiveTripCubit(
        gh<_i224.TripFacade>(),
        gh<_i404.RealtimeService>(),
        gh<_i814.AuthManager>(),
      ),
    );
    gh.lazySingleton<_i501.ProfileFacade>(
      () => _i501.ProfileFacade(gh<_i482.ProfileRepository>()),
    );
    gh.factory<_i951.ProfileBloc>(
      () => _i951.ProfileBloc(gh<_i501.ProfileFacade>()),
    );
    gh.lazySingleton<_i770.RootFacade>(
      () => _i770.RootFacade(gh<_i549.RootRepository>()),
    );
    gh.lazySingleton<_i925.OrderFacade>(
      () => _i925.OrderFacade(gh<_i153.OrderRepository>()),
    );
    gh.lazySingleton<_i561.PaymentFacade>(
      () => _i561.PaymentFacade(gh<_i951.PaymentRepository>()),
    );
    gh.lazySingleton<_i264.RefundIssueFacade>(
      () => _i264.RefundIssueFacade(gh<_i411.RefundIssueRepository>()),
    );
    gh.factory<_i174.ChatBloc>(
      () => _i174.ChatBloc(
        gh<_i698.ChatRepository>(),
        gh<_i404.RealtimeService>(),
        gh<_i814.AuthManager>(),
      ),
    );
    gh.factory<_i792.PaymentBloc>(
      () => _i792.PaymentBloc(gh<_i561.PaymentFacade>()),
    );
    gh.lazySingleton<_i239.AuthFacade>(
      () => _i239.AuthFacade(gh<_i618.AuthRepository>()),
    );
    gh.factory<_i144.RootBloc>(
      () => _i144.RootBloc(
        gh<_i102.PermissionsCoordinator>(),
        gh<_i396.LocationService>(),
        gh<_i925.OrderFacade>(),
      ),
    );
    gh.factory<_i62.RefundIssueBloc>(
      () => _i62.RefundIssueBloc(gh<_i264.RefundIssueFacade>()),
    );
    gh.factory<_i47.OrderBloc>(
      () => _i47.OrderBloc(
        gh<_i925.OrderFacade>(),
        gh<_i396.LocationService>(),
        gh<_i768.ClientConfigService>(),
        gh<_i404.RealtimeService>(),
        gh<_i561.PaymentFacade>(),
      ),
    );
    gh.factory<_i499.FavoritesBloc>(
      () => _i499.FavoritesBloc(
        gh<_i925.OrderFacade>(),
        gh<_i396.LocationService>(),
      ),
    );
    gh.factory<_i781.AuthBloc>(() => _i781.AuthBloc(gh<_i239.AuthFacade>()));
    gh.factory<_i404.PhoneVerificationCubit>(
      () => _i404.PhoneVerificationCubit(gh<_i239.AuthFacade>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i548.RegisterModule {}
