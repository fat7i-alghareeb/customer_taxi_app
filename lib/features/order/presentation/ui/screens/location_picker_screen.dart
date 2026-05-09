import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_request_entity.dart';
import 'package:customertaxi/features/order/domain/repositories/order_repository.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/map/root_map_canvas_widget.dart';
import 'package:customertaxi/features/order/presentation/ui/widgets/sheet/order_center_pin_widget.dart';
import 'package:customertaxi/core/services/location/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerScreen extends StatefulWidget {
  static const String pagePath = '/location_picker';
  static const String pageName = 'LocationPickerScreen';

  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? _currentCameraTarget;
  bool _isLoading = false;

  RootMapLocationEntity? _initialLocation;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      final pos = await getIt<LocationService>().getCurrentPosition();
      if (mounted) {
        setState(() {
          _initialLocation = RootMapLocationEntity(
            latitude: pos.latitude,
            longitude: pos.longitude,
            zoom: 15,
          );
          _currentCameraTarget = LatLng(pos.latitude, pos.longitude);
        });
      }
    } catch (e) {
      // Fallback to a default location or show error
      if (mounted) {
        setState(() {
          _initialLocation = const RootMapLocationEntity(
            latitude: 51.9225, // Rotterdam as default fallback
            longitude: 4.47917,
            zoom: 12,
          );
        });
      }
    }
  }

  void _onCameraMove(CameraPosition position) {
    _currentCameraTarget = position.target;
  }

  Future<void> _confirmLocation() async {
    if (_currentCameraTarget == null || _isLoading) return;

    setState(() => _isLoading = true);

    final result = await getIt<OrderRepository>().reverseGeocode(
      OrderReverseGeocodeRequestEntity(
        latitude: _currentCameraTarget!.latitude,
        longitude: _currentCameraTarget!.longitude,
      ),
    );

    setState(() => _isLoading = false);

    result.when(
      success: (location) {
        if (mounted) {
          context.pop(location);
        }
      },
      failure: (message) {
        if (mounted) {
          showErrorOverlay(context, message);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(title: AppStrings.setOnMap),
      child: Stack(
        children: [
          if (_initialLocation != null)
            RootMapCanvasWidget(
              currentLocation: _initialLocation!,
              onMapCreated: (_) {},
              onCameraMove: _onCameraMove,
              showMyLocationButton: true,
            )
          else
            Center(child: LoadingDots(color: context.primary)),

          const OrderCenterPinWidget(),

          Positioned(
            left: AppSpacing.lg.w,
            right: AppSpacing.lg.w,
            bottom: context.bottomPadding + AppSpacing.lg.h,
            child: AppButton.primary(
              isActive: !_isLoading && _initialLocation != null,
              onTap: _confirmLocation,
              layout: AppButtonLayout(
                width: double.infinity,
                height: 54.h,
                borderRadius: AppRadii.lg,
              ),
              child: _isLoading
                  ? AppButtonChild.custom(LoadingDots(color: context.onPrimary))
                  : AppButtonChild.label(AppStrings.confirmPoint),
            ),
          ),
        ],
      ),
    );
  }
}
