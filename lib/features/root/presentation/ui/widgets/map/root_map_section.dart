import 'dart:ui' show lerpDouble;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/root/constants/root_constants.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart';

import '../../../../../../utils/constants/app_flow_constants.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';
import 'package:customertaxi/features/order/constants/order_constants.dart';
import 'package:customertaxi/features/order/domain/entities/order_location_entity.dart';
import 'package:customertaxi/features/order/domain/entities/order_trip_route_entity.dart';
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
  final Map<String, BitmapDescriptor> _stopMarkers = {};
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
    // Too noisy for normal logs, but user asked for intensive
    printGray('[RootMapSection] _onCameraMove target=${position.target.latitude},${position.target.longitude} zoom=${position.zoom}');
    _lastCameraPosition = position;
  }

  void _onCameraIdle() {
    printM('[RootMapSection] _onCameraIdle');
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
      if (!mounted) return;
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
      if (mounted) {
        setState(() {
          _currentLocation = location;
        });
      }

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
      if (mounted) {
        setState(() {
          _currentLocation = location;
        });
      }
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

  List<List<LatLng>> _extractLegPolylinePoints(OrderState orderState) {
    return orderState.trip.routeState.maybeWhen(
      success: (route) => route.legs
          .map(
            (leg) => leg.points
                .map((p) => LatLng(p.latitude, p.longitude))
                .toList(),
          )
          .toList(),
      orElse: () => const <List<LatLng>>[],
    );
  }

  String _cleanLabel(String label) {
    return label.replaceAll('(', '').replaceAll(')', '').trim();
  }

  LatLng? _calculateMidpoint(List<LatLng> points) {
    if (points.isEmpty) return null;
    return points[points.length ~/ 2];
  }

  Future<void> _generateStopMarkers(OrderTripRouteEntity route) async {
    final Set<String> labels = {};
    for (final leg in route.legs) {
      final start = _cleanLabel(leg.startLabel);
      final end = _cleanLabel(leg.endLabel);
      if (start.isNotEmpty) labels.add(start);
      if (end.isNotEmpty) labels.add(end);
    }

    for (final label in labels) {
      if (_stopMarkers.containsKey(label)) continue;

      final isStart = label == _cleanLabel(route.legs.first.startLabel);
      final marker = await MapMarkerGenerator.createLabelMarker(
        text: label,
        color: isStart ? Colors.orange : Colors.blue,
      );

      if (mounted) {
        setState(() {
          _stopMarkers[label] = marker;
        });
      }
    }
  }

  Set<Marker> _buildTripMarkers(OrderState orderState) {
    final route = orderState.trip.routeState.maybeWhen(
      success: (route) => route,
      orElse: () => null,
    );

    if (route == null || orderState.stops.list.isEmpty) {
      return const <Marker>{};
    }

    final markers = <Marker>{};
    final legs = route.legs;
    final validStops =
        orderState.stops.list.whereType<OrderLocationEntity>().toList();

    for (int i = 0; i < legs.length; i++) {
      final leg = legs[i];

      if (i == 0 && validStops.isNotEmpty) {
        final label = _cleanLabel(leg.startLabel);
        markers.add(
          Marker(
            markerId: const MarkerId('trip-stop-start'),
            position: LatLng(validStops[0].latitude, validStops[0].longitude),
            icon:
                _stopMarkers[label] ??
                BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange,
                ),
          ),
        );
      }

      if (validStops.length > i + 1) {
        final isLast = i == legs.length - 1;
        final label = _cleanLabel(leg.endLabel);
        markers.add(
          Marker(
            markerId: MarkerId('trip-stop-${isLast ? "end" : i + 1}'),
            position: LatLng(
              validStops[i + 1].latitude,
              validStops[i + 1].longitude,
            ),
            icon:
                _stopMarkers[label] ??
                BitmapDescriptor.defaultMarkerWithHue(
                  isLast ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueOrange,
                ),
          ),
        );
      }
    }

    final points = route.legs.expand((l) => l.points).map((p) => LatLng(p.latitude, p.longitude)).toList();
    final midpoint = _calculateMidpoint(points);
    final etaText = route.durationText;

    if (etaText.isNotEmpty) {
      _updateEtaMarker(etaText);
      if (midpoint != null) {
        markers.add(
          Marker(
            markerId: const MarkerId('trip-eta'),
            position: midpoint,
            icon:
                _customMarkers['ETA'] ??
                BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange,
                ),
            anchor: const Offset(0.5, 0.5),
          ),
        );
      }
    }

    return markers;
  }


  Future<void> _fitRouteBoundsForState(OrderState orderState) async {
    final controller = _mapController;
    if (controller == null || !orderState.trip.routeState.isSuccess) {
      return;
    }

    final route = orderState.trip.routeState.maybeWhen(
      success: (value) => value,
      orElse: () => null,
    );

    final fromLocation = orderState.stops.list.isNotEmpty ? orderState.stops.list.first : null;
    final toLocation = orderState.stops.list.isNotEmpty ? orderState.stops.list.last : null;

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
    final fitPadding = orderState.sheet.mode == OrderSheetMode.expanded
        ? context.screenHeight * OrderConstants.expandedRouteFitPaddingFactor
        : 72.w;

    try {
      // Check if view size is likely to be large enough for padding
      // This is a heuristic to prevent 'View size is too small' PlatformException
      final viewWidth = context.screenWidth;
      final viewHeight = context.screenHeight;

      if (viewWidth < fitPadding * 2 || viewHeight < fitPadding * 2) {
        printY(
          '[RootMapSection] fit bounds skipped: view size (${viewWidth.toStringAsFixed(0)}x${viewHeight.toStringAsFixed(0)}) '
          'is too small for padding ${fitPadding.toStringAsFixed(0)}',
        );
        return;
      }

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
    if (!orderState.trip.routeState.isSuccess) {
      return;
    }

    _fitRouteBoundsForState(orderState);

    orderState.trip.routeState.maybeWhen(
      success: (route) => _generateStopMarkers(route),
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    printM('[RootMapSection] build');
    return MultiBlocListener(
      listeners: [
        BlocListener<RootBloc, RootState>(
          listenWhen: (previous, current) =>
              previous.recenterState != current.recenterState,
          listener: _handleRecenterState,
        ),
        BlocListener<OrderBloc, OrderState>(
          listenWhen: (previous, current) =>
              previous.trip.routeState != current.trip.routeState,
          listener: _handleTripRouteState,
        ),
      ],
      child:
          Stack(
                fit: StackFit.expand,
                children: [
                  BlocBuilder<OrderBloc, OrderState>(
                    buildWhen: (previous, current) =>
                        previous.trip.routeState != current.trip.routeState ||
                        previous.stops != current.stops,
                    builder: (context, orderState) {
                      final toLocation = orderState.stops.list.isNotEmpty
                          ? orderState.stops.list.last
                          : null;

                        return RootMapCanvasWidget(
                          currentLocation: _currentLocation,
                          destinationLocation:
                              toLocation == null
                                  ? null
                                  : LatLng(
                                    toLocation.latitude,
                                    toLocation.longitude,
                                  ),
                          legPolylines: _extractLegPolylinePoints(orderState),
                          tripMarkers: _buildTripMarkers(orderState),
                          onMapCreated: _onMapCreated,
                          onCameraMove: _onCameraMove,
                          onCameraIdle: _onCameraIdle,
                          showMyLocationButton:
                              orderState.sheet.mode == OrderSheetMode.mapPicking,
                        );
                    },
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    buildWhen: (p, c) => p.sheet.mode != c.sheet.mode,
                    builder: (context, orderState) {
                      final double sheetHeight = switch (orderState.sheet.mode) {
                        OrderSheetMode.collapsed =>
                          RootConstants.bottomNavHeight.sp + AppSpacing.md.h,
                        OrderSheetMode.mapPicking => 160.sp,
                        OrderSheetMode.expanded =>
                          context.screenHeight *
                              OrderConstants.expandedSheetHeightFactor,
                      };

                      // Only show controls if the sheet is not expanded
                      if (orderState.sheet.mode == OrderSheetMode.expanded) {
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
                        previous.trip.routeState != current.trip.routeState,
                    builder: (context, orderState) {
                      return orderState.trip.routeState.maybeWhen(
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
