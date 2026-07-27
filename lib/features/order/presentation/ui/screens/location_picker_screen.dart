import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_request_entity.dart';
import 'package:customertaxi/features/order/domain/repositories/order_repository.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/map/root_map_canvas_widget.dart';
import 'package:customertaxi/features/order/presentation/ui/widgets/sheet/order_center_pin_widget.dart';
import 'package:customertaxi/core/services/location/location_service.dart';
import 'package:customertaxi/utils/constants/app_flow_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerScreen extends StatefulWidget {
  static const String pagePath = '/location_picker';
  static const String pageName = 'LocationPickerScreen';

  const LocationPickerScreen({super.key, this.initialLocation});

  /// Optional starting point for the map camera. When provided, the picker opens
  /// centered on this location instead of the device's current GPS position —
  /// used to reposition an already-selected point.
  final RootMapLocationEntity? initialLocation;

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  static const String _searchField = 'locationSearch';

  LatLng? _currentCameraTarget;
  bool _isLoading = false;
  bool _isSearching = false;
  int _searchToken = 0;
  List<OrderLocationEntity> _searchResults = const [];

  RootMapLocationEntity? _initialLocation;
  final FormGroup _searchForm = FormGroup({
    _searchField: FormControl<String>(),
  });

  @override
  void dispose() {
    _searchForm.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    // Reposition mode: start centered on the provided point.
    final initial = widget.initialLocation;
    if (initial != null) {
      setState(() {
        _initialLocation = initial;
        _currentCameraTarget = LatLng(initial.latitude, initial.longitude);
      });
      return;
    }

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
      // Fallback to the app default centre, and seed the camera with it too so
      // address search still has a bias point.
      if (mounted) {
        setState(() {
          _initialLocation = const RootMapLocationEntity(
            latitude: MapConfig.defaultLat,
            longitude: MapConfig.defaultLng,
            zoom: 12,
          );
          _currentCameraTarget = const LatLng(
            MapConfig.defaultLat,
            MapConfig.defaultLng,
          );
        });
      }
    }
  }

  void _onCameraMove(CameraPosition position) {
    _currentCameraTarget = position.target;
  }

  Future<void> _searchLocations(String value) async {
    final query = value.trim();
    final token = ++_searchToken;

    if (query.length < 2) {
      setState(() {
        _isSearching = false;
        _searchResults = const [];
      });
      return;
    }

    setState(() => _isSearching = true);
    final target = _currentCameraTarget;
    // The camera can still be unresolved here (init in flight, or location
    // lookup failed), and the search is rejected without coordinates.
    final bias = await getIt<LocationService>().resolveSearchBias(
      fallbackLat: target?.latitude,
      fallbackLng: target?.longitude,
    );
    final result = await getIt<OrderRepository>().searchLocations(
      OrderLocationSearchRequestEntity(
        query: query,
        biasLat: bias.lat,
        biasLng: bias.lng,
      ),
    );

    if (!mounted || token != _searchToken) return;

    result.when(
      success: (locations) {
        setState(() {
          _isSearching = false;
          _searchResults = locations;
        });
      },
      failure: (message) {
        setState(() {
          _isSearching = false;
          _searchResults = const [];
        });
        showErrorOverlay(context, message);
      },
    );
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

    if (!mounted) return;
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
      child: ReactiveForm(
        formGroup: _searchForm,
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
              top: AppSpacing.lg.h,
              left: AppSpacing.lg.w,
              right: AppSpacing.lg.w,
              child: Column(
                children: [
                  Material(
                    elevation: 5,
                    shadowColor: Colors.black26,
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                    child: AppReactiveTextField.text(
                      formControlName: _searchField,
                      hintText: AppStrings.searchToLocation,
                      onChangedDebounced: (value, _) => _searchLocations(value),
                      prefix: Icon(
                        Icons.search,
                        size: 20.r,
                        color: context.primary,
                      ),
                    ),
                  ),
                  if (_isSearching || _searchResults.isNotEmpty)
                    Container(
                      margin: REdgeInsets.only(top: AppSpacing.sm),
                      constraints: BoxConstraints(maxHeight: 300.h),
                      decoration: BoxDecoration(
                        color: context.surface,
                        borderRadius: BorderRadius.circular(AppRadii.lg.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _isSearching
                          ? Padding(
                              padding: REdgeInsets.all(AppSpacing.lg),
                              child: LoadingDots(color: context.primary),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              padding: REdgeInsets.symmetric(
                                vertical: AppSpacing.sm,
                              ),
                              itemCount: _searchResults.length,
                              separatorBuilder: (_, _) => Divider(
                                height: 1,
                                color: context.onSurface.withValues(
                                  alpha: 0.08,
                                ),
                              ),
                              itemBuilder: (context, index) {
                                final location = _searchResults[index];
                                return ListTile(
                                  leading: Icon(
                                    Icons.location_on_outlined,
                                    color: context.primary,
                                  ),
                                  title: Text(
                                    location.primaryName ?? location.label,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle:
                                      location.secondaryAddress?.isNotEmpty ==
                                          true
                                      ? Text(
                                          location.secondaryAddress!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : null,
                                  onTap: () => context.pop(location),
                                );
                              },
                            ),
                    ),
                ],
              ),
            ),
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
                    ? AppButtonChild.custom(
                        LoadingDots(color: context.onSurface),
                      )
                    : AppButtonChild.label(AppStrings.confirmPoint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
