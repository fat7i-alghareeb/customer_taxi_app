import 'dart:ui' show lerpDouble;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/root/constants/root_constants.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart';

import '../../../../../../utils/constants/app_flow_constants.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';
import 'package:customertaxi/features/order/constants/order_constants.dart';
import 'root_map_canvas_widget.dart';
import 'root_map_controls_section.dart';
import 'root_map_eta_pill_widget.dart';
import '../../../utils/map_marker_generator.dart';

class RootMapSection extends StatefulWidget {
  const RootMapSection({
    super.key,
    required this.initialLocation,
    this.onCameraIdleLocationChanged,
  });

  final RootMapLocationEntity initialLocation;
  final ValueChanged<RootMapLocationEntity>? onCameraIdleLocationChanged;

  @override
  State<RootMapSection> createState() => _RootMapSectionState();
}

class _RootMapSectionState extends State<RootMapSection>
    with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  late RootMapLocationEntity _currentLocation;
  bool _isAnimating = false;
  late final AnimationController _flightController;
  CameraPosition? _lastCameraPosition;
  final Map<String, BitmapDescriptor> _customMarkers = {};
  String? _lastEtaText;

  @override
  void initState() {
    super.initState();
    _currentLocation = widget.initialLocation;
    _flightController = AnimationController(
      vsync: this,
      duration: MapConfig.flightDuration,
    );
    _initStaticMarkers();
    printC(
      '[RootMapSection] initState '
      'lat=${_currentLocation.latitude} lng=${_currentLocation.longitude}',
    );
  }

  @override
  void didUpdateWidget(covariant RootMapSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialLocation != widget.initialLocation) {
      printM(
        '[RootMapSection] initialLocation changed '
        'old=(${oldWidget.initialLocation.latitude},${oldWidget.initialLocation.longitude}) '
        'new=(${widget.initialLocation.latitude},${widget.initialLocation.longitude})',
      );
      _currentLocation = widget.initialLocation;
      _animateToLocation(widget.initialLocation);
    }
  }

  @override
  void dispose() {
    printC('[RootMapSection] dispose mapController=${_mapController != null}');
    _flightController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    printG('[RootMapSection] onMapCreated');
    _mapController = controller;
    _fitRouteBoundsForState(context.read<OrderBloc>().state);
  }

  void _onCameraMove(CameraPosition position) {
    _lastCameraPosition = position;
  }

  void _onCameraIdle() {
    final target = _lastCameraPosition;
    if (target == null) return;

    widget.onCameraIdleLocationChanged?.call(
      RootMapLocationEntity(
        latitude: target.target.latitude,
        longitude: target.target.longitude,
        zoom: target.zoom,
      ),
    );
  }

  // Zoom methods removed as requested

  LatLng _lerpLatLng(LatLng a, LatLng b, double t) {
    return LatLng(
      a.latitude + (b.latitude - a.latitude) * t,
      a.longitude + (b.longitude - a.longitude) * t,
    );
  }

  void _onRecenterTap() {
    printC('[RootMapSection] recenter requested');
    context.read<RootBloc>().add(const RootEvent.recenterRequested());
  }

  Future<void> _animateToLocation(RootMapLocationEntity location) async {
    if (_isAnimating) {
      printY('[RootMapSection] animation already in progress');
      return;
    }

    final controller = _mapController;
    if (controller == null) {
      printY('[RootMapSection] animate skipped (controller not ready)');
      setState(() {
        _currentLocation = location;
      });
      return;
    }

    _isAnimating = true;

    try {
      final target = LatLng(location.latitude, location.longitude);

      // Get current center and zoom
      final visibleRegion = await controller.getVisibleRegion();
      final startCenter = LatLng(
        (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) /
            2,
        (visibleRegion.northeast.longitude +
                visibleRegion.southwest.longitude) /
            2,
      );
      final startZoom = await controller.getZoomLevel();
      final targetZoom = location.zoom;

      final distance = Geolocator.distanceBetween(
        startCenter.latitude,
        startCenter.longitude,
        target.latitude,
        target.longitude,
      );

      printM(
        '[RootMapSection] cinematic animation distance=${distance.toStringAsFixed(1)}m',
      );

      // Update marker position immediately
      setState(() {
        _currentLocation = location;
      });

      if (distance > 50) {
        // --- CUSTOM CINEMATIC FLIGHT ---
        _flightController.reset();

        final Completer<void> animationCompleter = Completer<void>();

        void listener() {
          final t = _flightController.value;
          final currentLatLng = _lerpLatLng(startCenter, target, t);

          double currentZoom;
          // Zoom out then zoom in curve
          if (t < 0.5) {
            currentZoom = lerpDouble(
              startZoom,
              MapConfig.flightZoomOut,
              t * 2,
            )!;
          } else {
            currentZoom = lerpDouble(
              MapConfig.flightZoomOut,
              targetZoom,
              (t - 0.5) * 2,
            )!;
          }

          controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLatLng, zoom: currentZoom),
            ),
          );
        }

        _flightController.addListener(listener);

        await _flightController.forward().then((_) {
          _flightController.removeListener(listener);
          animationCompleter.complete();
        });

        await animationCompleter.future;
      } else {
        // Direct move if close
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: target, zoom: targetZoom),
          ),
        );
      }
    } catch (e) {
      printY('[RootMapSection] animation failed: $e');
      setState(() {
        _currentLocation = location;
      });
    } finally {
      _isAnimating = false;
    }
  }

  Future<void> _initStaticMarkers() async {
    final aMarker = await MapMarkerGenerator.createCustomMarker(
      text: 'A',
      color: Colors.orange,
      size: 45,
    );
    final bMarker = await MapMarkerGenerator.createCustomMarker(
      text: 'B',
      color: Colors.blue,
      size: 45,
    );

    if (mounted) {
      setState(() {
        _customMarkers['A'] = aMarker;
        _customMarkers['B'] = bMarker;
      });
    }
  }

  Future<void> _updateEtaMarker(String etaText) async {
    if (_lastEtaText == etaText) return;

    final etaMarker = await MapMarkerGenerator.createCustomMarker(
      text: etaText,
      color: Colors.orange,
      size: 55, // Balanced for ETA
      isEta: true,
    );

    if (mounted) {
      setState(() {
        _customMarkers['ETA'] = etaMarker;
        _lastEtaText = etaText;
      });
    }
  }

  void _handleRecenterState(BuildContext context, RootState state) {
    state.recenterState.when(
      initial: () {},
      loading: () {
        printM('[RootMapSection] recenter state=loading');
      },
      success: (location) {
        printG('[RootMapSection] recenter state=success');
        _animateToLocation(location);
      },
      failure: (message) {
        printY('[RootMapSection] recenter state=failure message=$message');
        if (!mounted || message.isEmpty) return;

        showErrorOverlay(context, message);
      },
    );
  }

  OrderLocationEntity? _extractOrderLocation(
    BlocStatus<OrderLocationEntity> locationState,
  ) {
    return locationState.maybeWhen(
      success: (location) => location,
      orElse: () => null,
    );
  }

  List<LatLng> _extractTripPolylinePoints(OrderState orderState) {
    return orderState.tripRouteState.maybeWhen(
      success: (route) => route.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList(),
      orElse: () => const <LatLng>[],
    );
  }

  LatLng? _calculateMidpoint(List<LatLng> points) {
    if (points.isEmpty) return null;
    return points[points.length ~/ 2];
  }

  Set<Marker> _buildTripMarkers(OrderState orderState) {
    final fromLocation = _extractOrderLocation(orderState.fromLocationState);
    final toLocation = _extractOrderLocation(orderState.toLocationState);

    if (!orderState.tripRouteState.isSuccess ||
        fromLocation == null ||
        toLocation == null) {
      return const <Marker>{};
    }

    final points = _extractTripPolylinePoints(orderState);
    final midpoint = _calculateMidpoint(points);
    final etaText = orderState.tripRouteState.maybeWhen(
      success: (route) => route.durationText,
      orElse: () => null,
    );

    if (etaText != null) {
      _updateEtaMarker(etaText);
    }

    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('trip-from-location'),
        position: LatLng(fromLocation.latitude, fromLocation.longitude),
        icon:
            _customMarkers['A'] ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        anchor: const Offset(0.5, 0.5),
      ),
      Marker(
        markerId: const MarkerId('trip-to-location'),
        position: LatLng(toLocation.latitude, toLocation.longitude),
        icon:
            _customMarkers['B'] ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        anchor: const Offset(0.5, 0.5),
      ),
    };

    if (midpoint != null && etaText != null && etaText.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId('trip-eta'),
          position: midpoint,
          icon:
              _customMarkers['ETA'] ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          anchor: const Offset(0.5, 0.5),
        ),
      );
    }

    return markers;
  }

  Future<void> _fitRouteBoundsForState(OrderState orderState) async {
    final controller = _mapController;
    if (controller == null || !orderState.tripRouteState.isSuccess) {
      return;
    }

    final route = orderState.tripRouteState.maybeWhen(
      success: (value) => value,
      orElse: () => null,
    );

    final fromLocation = _extractOrderLocation(orderState.fromLocationState);
    final toLocation = _extractOrderLocation(orderState.toLocationState);

    if (route == null || fromLocation == null || toLocation == null) {
      return;
    }

    final points = <LatLng>[
      LatLng(fromLocation.latitude, fromLocation.longitude),
      ...route.points.map((point) => LatLng(point.latitude, point.longitude)),
      LatLng(toLocation.latitude, toLocation.longitude),
    ];

    if (points.length < 2) {
      return;
    }

    final bounds = _resolveBounds(points);
    final fitPadding = orderState.sheetMode == OrderSheetMode.expanded
        ? context.screenHeight * OrderConstants.expandedRouteFitPaddingFactor
        : 72.w;

    try {
      await controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, fitPadding),
      );
    } catch (e) {
      printY('[RootMapSection] fit bounds failed: $e');
    }
  }

  LatLngBounds _resolveBounds(List<LatLng> points) {
    var minLat = points.first.latitude;
    var maxLat = points.first.latitude;
    var minLng = points.first.longitude;
    var maxLng = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) {
        minLat = point.latitude;
      }
      if (point.latitude > maxLat) {
        maxLat = point.latitude;
      }
      if (point.longitude < minLng) {
        minLng = point.longitude;
      }
      if (point.longitude > maxLng) {
        maxLng = point.longitude;
      }
    }

    const delta = 0.001;
    if ((maxLat - minLat).abs() < 0.0001) {
      maxLat += delta;
      minLat -= delta;
    }

    if ((maxLng - minLng).abs() < 0.0001) {
      maxLng += delta;
      minLng -= delta;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  void _handleTripRouteState(BuildContext context, OrderState orderState) {
    if (!orderState.tripRouteState.isSuccess) {
      return;
    }

    _fitRouteBoundsForState(orderState);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RootBloc, RootState>(
          listenWhen: (previous, current) =>
              previous.recenterState != current.recenterState,
          listener: _handleRecenterState,
        ),
        BlocListener<OrderBloc, OrderState>(
          listenWhen: (previous, current) =>
              previous.tripRouteState != current.tripRouteState,
          listener: _handleTripRouteState,
        ),
      ],
      child:
          Stack(
                fit: StackFit.expand,
                children: [
                  BlocBuilder<OrderBloc, OrderState>(
                    buildWhen: (previous, current) =>
                        previous.tripRouteState != current.tripRouteState ||
                        previous.fromLocationState !=
                            current.fromLocationState ||
                        previous.toLocationState != current.toLocationState,
                    builder: (context, orderState) {
                      final toLocation = _extractOrderLocation(
                        orderState.toLocationState,
                      );

                      return RootMapCanvasWidget(
                        currentLocation: _currentLocation,
                        destinationLocation: toLocation == null
                            ? null
                            : LatLng(toLocation.latitude, toLocation.longitude),
                        tripPolylinePoints: _extractTripPolylinePoints(
                          orderState,
                        ),
                        tripMarkers: _buildTripMarkers(orderState),
                        onMapCreated: _onMapCreated,
                        onCameraMove: _onCameraMove,
                        onCameraIdle: _onCameraIdle,
                        showMyLocationButton:
                            orderState.sheetMode == OrderSheetMode.mapPicking,
                      );
                    },
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    buildWhen: (p, c) => p.sheetMode != c.sheetMode,
                    builder: (context, orderState) {
                      final double sheetHeight = switch (orderState.sheetMode) {
                        OrderSheetMode.collapsed =>
                          RootConstants.bottomNavHeight.sp + AppSpacing.md.h,
                        OrderSheetMode.mapPicking => 160.sp,
                        OrderSheetMode.expanded =>
                          context.screenHeight *
                              OrderConstants.expandedSheetHeightFactor,
                      };

                      // Only show controls if the sheet is not expanded
                      if (orderState.sheetMode == OrderSheetMode.expanded) {
                        return const SizedBox.shrink();
                      }

                      return AnimatedPositionedDirectional(
                        duration: AppDurations.slow,
                        curve: Curves.easeInOut,
                        end: AppSpacing.xl,
                        bottom:
                            context.bottomPadding +
                            sheetHeight +
                            AppSpacing.xxl,
                        child: BlocBuilder<RootBloc, RootState>(
                          buildWhen: (previous, current) =>
                              previous.recenterState != current.recenterState,
                          builder: (context, state) {
                            return RootMapControlsSection(
                              onRecenterTap: _onRecenterTap,
                              recenterLoading: state.recenterState.isLoading,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    buildWhen: (previous, current) =>
                        previous.tripRouteState != current.tripRouteState,
                    builder: (context, orderState) {
                      return orderState.tripRouteState.maybeWhen(
                        success: (route) => Positioned(
                          top: 50.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: RootMapEtaPillWidget(
                              durationText: route.durationText,
                            ),
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: 280.ms)
              .slideY(begin: 0.02, end: 0, duration: 280.ms),
    );
  }
}
