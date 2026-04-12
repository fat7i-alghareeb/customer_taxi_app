import 'dart:ui' show lerpDouble;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart';

import '../../../../../../utils/constants/app_flow_constants.dart';
import 'root_map_canvas_widget.dart';
import 'root_map_controls_section.dart';

class RootMapSection extends StatefulWidget {
  const RootMapSection({super.key, required this.initialLocation});

  final RootMapLocationEntity initialLocation;

  @override
  State<RootMapSection> createState() => _RootMapSectionState();
}

class _RootMapSectionState extends State<RootMapSection>
    with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  late RootMapLocationEntity _currentLocation;
  bool _isAnimating = false;
  late final AnimationController _flightController;

  @override
  void initState() {
    super.initState();
    _currentLocation = widget.initialLocation;
    _flightController = AnimationController(
      vsync: this,
      duration: MapConfig.flightDuration,
    );
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
  }

  Future<void> _onZoomInTap() async {
    final controller = _mapController;
    if (controller == null) {
      printY('[RootMapSection] zoomIn ignored (controller not ready)');
      return;
    }

    printM('[RootMapSection] zoomIn');

    await controller.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> _onZoomOutTap() async {
    final controller = _mapController;
    if (controller == null) {
      printY('[RootMapSection] zoomOut ignored (controller not ready)');
      return;
    }

    printM('[RootMapSection] zoomOut');

    await controller.animateCamera(CameraUpdate.zoomOut());
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<RootBloc, RootState>(
      listenWhen: (previous, current) =>
          previous.recenterState != current.recenterState,
      listener: _handleRecenterState,
      child:
          Stack(
                fit: StackFit.expand,
                children: [
                  RootMapCanvasWidget(
                    currentLocation: _currentLocation,
                    onMapCreated: _onMapCreated,
                  ),
                  PositionedDirectional(
                    end: 30.w,
                    bottom: 40.h,
                    child: BlocBuilder<RootBloc, RootState>(
                      buildWhen: (previous, current) =>
                          previous.recenterState != current.recenterState,
                      builder: (context, state) {
                        return RootMapControlsSection(
                          onRecenterTap: _onRecenterTap,
                          onZoomInTap: () {
                            _onZoomInTap();
                          },
                          onZoomOutTap: () {
                            _onZoomOutTap();
                          },
                          recenterLoading: state.recenterState.isLoading,
                        );
                      },
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: 280.ms)
              .slideY(begin: 0.02, end: 0, duration: 280.ms),
    );
  }
}
