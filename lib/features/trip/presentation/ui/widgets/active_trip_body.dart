import 'dart:ui' as ui;

import 'package:flutter/services.dart' show SystemSound, SystemSoundType;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/map/root_map_canvas_widget.dart';
import 'package:customertaxi/features/root/presentation/utils/map_marker_generator.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_status.dart';
import 'package:customertaxi/features/trip/domain/entities/driver_location_entity.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/coordinators/trip_completion_coordinator.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/cancel_trip_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/live_arrival_overlay.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_cancelled_success_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/passenger_note_sheet.dart';
import 'package:customertaxi/features/chat/presentation/states/chat_bloc.dart';
import 'package:vibration/vibration.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/passenger_note_floating_action.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/glassmorphic_trip_status_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_status_banner.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_completed_overlay.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_no_driver_overlay.dart';

class ActiveTripBody extends StatefulWidget {
  const ActiveTripBody({super.key});

  @override
  State<ActiveTripBody> createState() => _ActiveTripBodyState();
}

class _ActiveTripBodyState extends State<ActiveTripBody>
    with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  BitmapDescriptor? _carMarkerIcon;
  BitmapDescriptor? _carMarkerIconFlipped;
  BitmapDescriptor? _pickupMarkerIcon;
  BitmapDescriptor? _destinationMarkerIcon;

  // Animation controller for smooth vehicle movement & rotation interpolation
  late final AnimationController _carMovementController;
  LatLng? _prevCarPosition;
  LatLng? _targetCarPosition;
  LatLng? _currentCarPosition;
  double _currentBearing = 0.0;
  double _targetBearing = 0.0;
  double _interpolatedBearing = 0.0;

  bool _arrivalAlertPlayed = false;
  bool _cancelledSheetShown = false;
  bool _noDriverCancelInProgress = false;
  TripStatus? _lastSeenTripStatus;

  // Road-following driver→pickup route, decoded from the backend location payload
  // and drawn dashed by the map canvas. Cached by encoded string to skip re-decoding.
  List<LatLng> _pickupRoute = const <LatLng>[];
  String? _lastPickupPolyline;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
    _primeArrivalGuardFromCurrentState();

    _carMovementController =
        AnimationController(
            vsync: this,
            // Interpolate over ~1.5s to keep pace with the ~1 Hz live location
            // stream so the car moves continuously instead of lagging behind.
            duration: const Duration(milliseconds: 1500),
          )
          ..addListener(_onCarMovementTick)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _currentBearing = _targetBearing;
            }
          });
  }

  @override
  void dispose() {
    _carMovementController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _loadCustomMarkers() async {
    try {
      final carIcon = await MapMarkerGenerator.createVehicleMarker(width: 56.r);
      final carIconFlipped = await MapMarkerGenerator.createVehicleMarker(
        width: 56.r,
        mirror: true,
      );
      // Dot-in-ring markers (solid dot, transparent gap, colored ring) replace the
      // old lettered A/B circles. Distinct colors keep pickup vs destination clear.
      final pickupIcon = await MapMarkerGenerator.createDotRingMarker(
        color: Colors.green,
        size: 45.r,
      );
      final destinationIcon = await MapMarkerGenerator.createDotRingMarker(
        color: Colors.orange,
        size: 45.r,
      );

      if (mounted) {
        setState(() {
          _carMarkerIcon = carIcon;
          _carMarkerIconFlipped = carIconFlipped;
          _pickupMarkerIcon = pickupIcon;
          _destinationMarkerIcon = destinationIcon;
        });
        printG('[ActiveTripBody] custom markers loaded');
      }
    } catch (e) {
      printY('[ActiveTripBody] Failed to load custom markers: $e');
    }
  }

  void _onCarMovementTick() {
    if (_prevCarPosition != null && _targetCarPosition != null) {
      setState(() {
        _currentCarPosition = _lerpLatLng(
          _prevCarPosition!,
          _targetCarPosition!,
          _carMovementController.value,
        );
        _interpolatedBearing = _lerpDouble(
          _currentBearing,
          _targetBearing,
          _carMovementController.value,
        );
      });
    }
  }

  LatLng _lerpLatLng(LatLng a, LatLng b, double t) {
    return LatLng(
      a.latitude + (b.latitude - a.latitude) * t,
      a.longitude + (b.longitude - a.longitude) * t,
    );
  }

  double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  /// Whether the heading has a westward (leftward) component, i.e. the car
  /// should be mirrored to face left. Bearing is degrees clockwise from north.
  bool _headingWest(double bearing) {
    double normalized = bearing % 360;
    if (normalized < 0) normalized += 360;
    return normalized > 180;
  }

  double _calculateBearing(LatLng from, LatLng to) {
    return Geolocator.bearingBetween(
      from.latitude,
      from.longitude,
      to.latitude,
      to.longitude,
    );
  }

  void _onMapCreated(GoogleMapController controller, TripEntity trip) {
    printC('[ActiveTripBody] map created trip=${trip.id}');
    _mapController = controller;
    _fitTripBounds(trip);
  }

  void _fitTripBounds(TripEntity trip) {
    final controller = _mapController;
    if (controller == null) return;

    final points = <LatLng>[];
    if (trip.stops.isNotEmpty) {
      points.add(LatLng(trip.stops.first.latitude, trip.stops.first.longitude));
      if (trip.stops.length > 1) {
        points.add(LatLng(trip.stops.last.latitude, trip.stops.last.longitude));
      }
    }

    if (_currentCarPosition != null) {
      points.add(_currentCarPosition!);
    }

    if (points.length < 2) return;

    printC('[ActiveTripBody] fitting map bounds points=${points.length}');
    final bounds = _resolveBounds(points);
    unawaited(
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 96.w)),
    );
  }

  LatLngBounds _resolveBounds(List<LatLng> points) {
    var minLat = points.first.latitude;
    var maxLat = points.first.latitude;
    var minLng = points.first.longitude;
    var maxLng = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
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

  void _primeArrivalGuardFromCurrentState() {
    final TripState current = context.read<TripBloc>().state;
    current.tripStatus.whenOrNull(
      success: (trip) {
        _lastSeenTripStatus = trip.status;
        if (trip.status == TripStatus.arrived) {
          _arrivalAlertPlayed = true;
        }

        // Seed the car position from whatever is already known at mount so the
        // first live event animates from it instead of snapping, and so the
        // marker shows immediately (the BlocListener never fires for the
        // mount-time state). Prefers the live location, falls back to the
        // persisted driver coordinate on the trip.
        final liveLoc = current.activeDriverLocation;
        final LatLng? seed = liveLoc != null
            ? LatLng(liveLoc.latitude, liveLoc.longitude)
            : (trip.driverLat != null && trip.driverLng != null
                  ? LatLng(trip.driverLat!, trip.driverLng!)
                  : null);
        if (seed != null) {
          _prevCarPosition = seed;
          _targetCarPosition = seed;
          _currentCarPosition = seed;
          final bearing = liveLoc?.bearing ?? 0.0;
          _currentBearing = bearing;
          _targetBearing = bearing;
          _interpolatedBearing = bearing;
        }
      },
    );
  }

  void _triggerArrivalAlert() {
    if (_arrivalAlertPlayed) return;
    _arrivalAlertPlayed = true;
    printG('[ActiveTripBody] driver arrived alert triggered');

    // Play native system beep sound
    SystemSound.play(SystemSoundType.alert);

    // Vibration feedback
    unawaited(() async {
      try {
        final hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator == true) {
          await Vibration.vibrate(pattern: [0, 500, 200, 500]);
        }
      } catch (_) {}
    }());
  }

  Future<void> _handleTripCancelled(
    BuildContext context,
    TripEntity trip,
  ) async {
    await TripCancelledSuccessSheet.show(
      context,
      cancellation: trip.cancellation,
    );
    if (context.mounted) {
      context.read<OrderBloc>().add(const OrderEvent.collapseRequested());
      getIt<ActiveTripCubit>().clear();
    }
  }

  /// Applies the road-following driver→target route delivered (already road-snapped)
  /// in the backend location payload. The target is the pickup while heading there
  /// (en-route / arrived) and the destination once on board (in-progress). Decodes
  /// only when the encoded string changes, and clears the route for any other status.
  void _applyPickupRoute(TripStatus status, String? encoded) {
    final hasLiveTarget =
        status == TripStatus.enRoute ||
        status == TripStatus.arrived ||
        status == TripStatus.inProgress;
    if (!hasLiveTarget || encoded == null || encoded.isEmpty) {
      if (_pickupRoute.isNotEmpty || _lastPickupPolyline != null) {
        setState(() {
          _pickupRoute = const <LatLng>[];
          _lastPickupPolyline = null;
        });
      }
      return;
    }

    if (encoded == _lastPickupPolyline) return;

    final decoded = PolylinePoints.decodePolyline(
      encoded,
    ).map((p) => LatLng(p.latitude, p.longitude)).toList();
    setState(() {
      _lastPickupPolyline = encoded;
      _pickupRoute = decoded;
    });
  }

  void _handleTripStateChange(BuildContext context, TripState state) {
    state.tripStatus.whenOrNull(
      success: (trip) {
        printC('[ActiveTripBody] trip state changed status=${trip.status}');
        if (trip.status == TripStatus.cancelled) {
          if (!_cancelledSheetShown) {
            _cancelledSheetShown = true;
            unawaited(_handleTripCancelled(context, trip));
          }
          return;
        }

        final isRealTransitionToArrived =
            _lastSeenTripStatus != TripStatus.arrived &&
            trip.status == TripStatus.arrived;
        _lastSeenTripStatus = trip.status;
        if (isRealTransitionToArrived) {
          _triggerArrivalAlert();
        }

        final liveLoc = state.activeDriverLocation;
        if (liveLoc != null) {
          final newPos = LatLng(liveLoc.latitude, liveLoc.longitude);
          printC(
            '[ActiveTripBody] live driver marker lat=${liveLoc.latitude} lng=${liveLoc.longitude}',
          );
          if (_targetCarPosition == null) {
            _prevCarPosition = newPos;
            _targetCarPosition = newPos;
            _currentCarPosition = newPos;
            _currentBearing = liveLoc.bearing ?? 0.0;
            _targetBearing = liveLoc.bearing ?? 0.0;
            _interpolatedBearing = liveLoc.bearing ?? 0.0;
          } else if (_targetCarPosition != newPos) {
            _prevCarPosition = _targetCarPosition;
            _targetCarPosition = newPos;
            _targetBearing =
                liveLoc.bearing ??
                _calculateBearing(_prevCarPosition!, _targetCarPosition!);
            _carMovementController.reset();
            _carMovementController.forward();
          }
          // Draw the road-following dashed line delivered by the backend payload.
          _applyPickupRoute(trip.status, liveLoc.routeToPickupPolyline);
        } else if (trip.driverLat != null && trip.driverLng != null) {
          final dbPos = LatLng(trip.driverLat!, trip.driverLng!);
          printC(
            '[ActiveTripBody] fallback driver marker lat=${trip.driverLat} lng=${trip.driverLng}',
          );
          if (_targetCarPosition == null) {
            _prevCarPosition = dbPos;
            _targetCarPosition = dbPos;
            _currentCarPosition = dbPos;
          }
        }

        // Terminal trips stay on this screen so the customer can browse the
        // receipt / invoice chips at their leisure. Dismissal is now explicit
        // via the Done button in [_buildCompletedSheet].
      },
    );
  }

  Set<Marker> _buildTripMarkers(TripEntity trip) {
    final markers = <Marker>{};
    if (trip.stops.isNotEmpty) {
      // Find the next uncompleted stop
      int nextStopIndex = -1;
      for (int i = 0; i < trip.stops.length; i++) {
        if (!trip.stops[i].isCompleted) {
          nextStopIndex = i;
          break;
        }
      }

      for (int i = 0; i < trip.stops.length; i++) {
        final stop = trip.stops[i];
        final isPickup = i == 0;
        final isDestination = i == trip.stops.length - 1;
        final isNext = i == nextStopIndex;

        BitmapDescriptor descriptor;
        if (isPickup) {
          descriptor =
              _pickupMarkerIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
        } else if (isDestination) {
          descriptor =
              _destinationMarkerIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
        } else {
          // Intermediate stop
          if (isNext) {
            // Highlight the next uncompleted stop in Red
            descriptor = BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            );
          } else if (stop.isCompleted) {
            // Completed stops in Green
            descriptor = BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            );
          } else {
            // Uncompleted subsequent stops in Violet
            descriptor = BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            );
          }
        }

        markers.add(
          Marker(
            markerId: MarkerId('trip-stop-${stop.sequence}-$i'),
            position: LatLng(stop.latitude, stop.longitude),
            icon: descriptor,
            infoWindow: InfoWindow(
              title:
                  stop.label ??
                  (isPickup
                      ? 'Pickup'
                      : isDestination
                      ? 'Destination'
                      : 'Stop ${i + 1}'),
              snippet: stop.isCompleted
                  ? 'Completed'
                  : isNext
                  ? 'Next Stop'
                  : 'Upcoming Stop',
            ),
          ),
        );
      }
    }
    return markers;
  }

  final Map<String, List<List<LatLng>>> _decodedRouteCache = {};

  List<List<LatLng>> _buildRoutePolylines(TripEntity trip) {
    if (trip.routeSegments.isNotEmpty) {
      final cacheKey = '${trip.id}|segments';
      final cached = _decodedRouteCache[cacheKey];
      if (cached != null) return cached;

      final decoded = trip.routeSegments
          .map(
            (segment) => PolylinePoints.decodePolyline(
              segment.encodedPolyline,
            ).map((p) => LatLng(p.latitude, p.longitude)).toList(),
          )
          .where((leg) => leg.isNotEmpty)
          .toList();

      if (decoded.isNotEmpty) {
        _decodedRouteCache[cacheKey] = decoded;
        return decoded;
      }
    }

    final overview = trip.encodedOverviewPolyline;
    if (overview != null && overview.isNotEmpty) {
      final cacheKey = '${trip.id}|overview';
      final cached = _decodedRouteCache[cacheKey];
      if (cached != null) return cached;

      final decoded = PolylinePoints.decodePolyline(
        overview,
      ).map((p) => LatLng(p.latitude, p.longitude)).toList();

      if (decoded.isNotEmpty) {
        final result = [decoded];
        _decodedRouteCache[cacheKey] = result;
        return result;
      }
    }

    final List<LatLng> stopPoints = trip.stops
        .map((s) => LatLng(s.latitude, s.longitude))
        .toList();
    return stopPoints.isNotEmpty ? [stopPoints] : const <List<LatLng>>[];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TripBloc, TripState>(
          listenWhen: (prev, curr) => prev.cancelStatus != curr.cancelStatus,
          listener: (context, state) {
            state.cancelStatus.whenOrNull(
              failure: (msg) => showErrorOverlay(context, msg),
            );
          },
        ),
        BlocListener<TripBloc, TripState>(
          listenWhen: (prev, curr) =>
              prev.passengerNoteStatus != curr.passengerNoteStatus,
          listener: (context, state) {
            state.passengerNoteStatus.whenOrNull(
              success: (_) =>
                  showSuccessOverlay(context, AppStrings.passengerNoteSaved),
              failure: (msg) => showErrorOverlay(context, msg),
            );
          },
        ),
        BlocListener<TripBloc, TripState>(
          listenWhen: (prev, curr) =>
              prev.tripStatus != curr.tripStatus ||
              prev.activeDriverLocation != curr.activeDriverLocation,
          listener: _handleTripStateChange,
        ),
      ],
      child: BlocBuilder<TripBloc, TripState>(
        builder: (context, state) {
          return StatusBuilder<TripEntity>(
            state: state.tripStatus,
            success: (trip) {
              final double lat = trip.stops.isNotEmpty
                  ? trip.stops.first.latitude
                  : 52.2297;
              final double lng = trip.stops.isNotEmpty
                  ? trip.stops.first.longitude
                  : 21.0122;
              final canEditPassengerNote = trip.status.canEditPassengerNote;

              // Render the car marker straight from bloc state, falling back to
              // the persisted driver coordinate on the trip. This guarantees the
              // marker is visible on first entry into an active trip even before
              // the animation side-effect in [_handleTripStateChange] has run
              // (which misses the mount-time state and drops events received while
              // the trip is still loading). Once the animation kicks in,
              // [_currentCarPosition] takes over for smooth movement.
              final liveLoc = state.activeDriverLocation;
              final LatLng? renderPos =
                  _currentCarPosition ??
                  (liveLoc != null
                      ? LatLng(liveLoc.latitude, liveLoc.longitude)
                      : (trip.driverLat != null && trip.driverLng != null
                            ? LatLng(trip.driverLat!, trip.driverLng!)
                            : null));
              final double renderBearing = _currentCarPosition != null
                  ? _interpolatedBearing
                  : (liveLoc?.bearing ?? 0.0);
              // The car asset is a side-view image kept upright; pick the
              // left-facing (mirrored) variant when the driver heads west so it
              // still faces its direction of travel.
              final BitmapDescriptor? carMarkerIcon =
                  _headingWest(renderBearing)
                  ? (_carMarkerIconFlipped ?? _carMarkerIcon)
                  : _carMarkerIcon;

              // The live dashed "car → target" line tracks the pickup while the
              // driver is heading there (en-route / arrived) and the destination
              // once the passenger is on board (in-progress).
              final bool headingToPickup =
                  trip.status == TripStatus.enRoute ||
                  trip.status == TripStatus.arrived;
              final bool tripInProgress = trip.status == TripStatus.inProgress;
              final LatLng? liveTargetLocation =
                  headingToPickup && trip.stops.isNotEmpty
                  ? LatLng(
                      trip.stops.first.latitude,
                      trip.stops.first.longitude,
                    )
                  : (tripInProgress && trip.stops.length > 1
                        ? LatLng(
                            trip.stops.last.latitude,
                            trip.stops.last.longitude,
                          )
                        : null);
              final List<LatLng> liveTargetRoute =
                  (headingToPickup || tripInProgress)
                  ? _pickupRoute
                  : const <LatLng>[];

              // Null for `enRoute` — that status keeps the plain live
              // driver-tracking map (no blur, no card).
              final bannerContent = TripStatusBannerContent.forStatus(
                trip.status,
              );

              return BlocProvider<ChatBloc>(
                create: (_) =>
                    getIt<ChatBloc>()..add(ChatEvent.opened(trip.id)),
                // The whole live-trip subtree runs on the orange accent, so
                // every `colors.primary` below (sheets, stepper, safety panel,
                // badges) picks it up without per-widget colour overrides.
                child: tripAccentTheme(
                  context,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Full Screen Background Tracking Map
                      RootMapCanvasWidget(
                        currentLocation: RootMapLocationEntity(
                          latitude: lat,
                          longitude: lng,
                          zoom: 14.5,
                        ),
                        destinationLocation: trip.stops.length > 1
                            ? LatLng(
                                trip.stops.last.latitude,
                                trip.stops.last.longitude,
                              )
                            : null,
                        legPolylines: _buildRoutePolylines(trip),
                        tripMarkers: _buildTripMarkers(trip),
                        onMapCreated: (ctrl) => _onMapCreated(ctrl, trip),
                        driverLocation: renderPos?.toDriverLocation(
                          renderBearing,
                        ),
                        driverMarkerIcon: carMarkerIcon,
                        // Live car→target dashed line: pickup while heading there
                        // (en-route / arrived), destination once on board (in-progress).
                        pickupLocation: liveTargetLocation,
                        pickupRoute: liveTargetRoute,
                      ),

                      // Full-screen blur over the map for the banner statuses —
                      // replaces the old status artwork. Covers the entire
                      // screen (the sheet simply paints on top of it), so no
                      // clip is needed. `enRoute` keeps the plain sharp map.
                      if (bannerContent != null)
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.12),
                            ),
                          ),
                        ),

                      // Top-left live arrival badge — shown whenever a live ETA is
                      // available: arrival at pickup (en-route / arrived) or at the
                      // destination (in-progress).
                      if (LiveArrival.hasEstimate(state.activeDriverLocation) &&
                          (trip.status == TripStatus.enRoute ||
                              trip.status == TripStatus.arrived ||
                              trip.status == TripStatus.inProgress))
                        Positioned(
                          top:
                              MediaQuery.of(context).padding.top +
                              AppSpacing.sm.h,
                          left: AppSpacing.lg.w,
                          child: LiveArrivalBadge(
                            etaSeconds:
                                state.activeDriverLocation!.etaToPickupSeconds!,
                          ).animate().fadeIn(duration: 300.ms),
                        ),

                      // Bottom overlay: the status card and the Note button are
                      // siblings stacked directly ABOVE the glass status sheet in
                      // one bottom-anchored column (not at a fixed offset), so
                      // they always clear it no matter how tall the sheet grows
                      // for a given trip state (e.g. the arrived sheet with the
                      // waiting-fee banner).
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Pinned physically left (Alignment.centerLeft, not
                            // directional) to match the card's own force-LTR
                            // layout in RTL locales.
                            if (bannerContent != null)
                              Padding(
                                padding: REdgeInsets.fromLTRB(
                                  AppSpacing.lg,
                                  0,
                                  AppSpacing.lg,
                                  AppSpacing.md,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TripStatusOverlayCard(
                                    icon: bannerContent.icon,
                                    title: bannerContent.title,
                                    bodyLines: bannerContent.bodyLines,
                                  ),
                                ),
                              ),
                            if (canEditPassengerNote)
                              Padding(
                                padding: REdgeInsets.fromLTRB(
                                  AppSpacing.xl,
                                  0,
                                  AppSpacing.xl,
                                  AppSpacing.sm,
                                ),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    PassengerNoteFloatingAction(
                                      hasNote:
                                          trip.passengerNote
                                              ?.trim()
                                              .isNotEmpty ==
                                          true,
                                      isLoading:
                                          state.passengerNoteStatus.isLoading,
                                      onTap: () => _showPassengerNoteSheet(
                                        context,
                                        trip,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            GlassmorphicTripStatusSheet(
                                  trip: trip,
                                  cancelStatus: state.cancelStatus,
                                  driverLocation: state.activeDriverLocation,
                                  onCancelPressed: () =>
                                      _showCancelDialog(context, trip),
                                )
                                .animate()
                                .fadeIn(duration: 350.ms)
                                .slideY(
                                  begin: 0.2,
                                  end: 0.0,
                                  duration: 350.ms,
                                  curve: Curves.easeOutCubic,
                                ),
                          ],
                        ),
                      ),

                      // Full-screen "thank you" overlay: derived (not latched)
                      // so it also shows when the trip is already completed at
                      // mount (cold reopen). Only the Close button dismisses it;
                      // the coordinator remembers the dismissal across remounts.
                      if (trip.status == TripStatus.completed &&
                          trip.passengerRating == null &&
                          !getIt<TripCompletionCoordinator>()
                              .isCompletedOverlayClosed(trip.id))
                        TripCompletedOverlay(
                          onClose: () {
                            setState(() {
                              getIt<TripCompletionCoordinator>()
                                  .markCompletedOverlayClosed(trip.id);
                            });
                            // Deferred to Close: run the original completion flow
                            // (navigate home + rating sheet) only now.
                            unawaited(
                              getIt<TripCompletionCoordinator>()
                                  .promptRatingForCompletedTrip(trip.id),
                            );
                          },
                        ),

                      // Blocking "no driver found" overlay. Driven by the backend
                      // flag (survives cold reopen). The second term keeps it mounted
                      // through the status→cancelled flip ONLY on a successful cancel
                      // so the apology phase can render; a failed cancel / admin-accept
                      // race no longer strands it (it falls back to the normal UI).
                      if ((trip.status == TripStatus.awaitingAdminAcceptance &&
                              trip.noDriverDecisionRequired) ||
                          (_noDriverCancelInProgress &&
                              state.cancelStatus.isSuccess))
                        TripNoDriverOverlay(
                          postponeStatus: state.postponeStatus,
                          cancelStatus: state.cancelStatus,
                          onPostpone: () => context.read<TripBloc>().add(
                            const TripEvent.noDriverPostponeRequested(),
                          ),
                          onCancel: () {
                            setState(() {
                              _noDriverCancelInProgress = true;
                              _cancelledSheetShown = true;
                            });
                            context.read<TripBloc>().add(
                              const TripEvent.noDriverCancelRequested(),
                            );
                          },
                          onDone: () {
                            getIt<ActiveTripCubit>().clear();
                            context.read<OrderBloc>().add(
                              const OrderEvent.collapseRequested(),
                            );
                            // Route home so Done exits in the standalone
                            // /active_trip route too (mirrors the completed sheet).
                            if (context.mounted) context.goNamed('RootScreen');
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showCancelDialog(BuildContext context, TripEntity trip) {
    printM('[ActiveTripBody] cancel sheet opened');
    unawaited(
      CancelTripSheet.show(context, trip).then((result) {
        if (result == null || !context.mounted) return;
        printM('[ActiveTripBody] cancel confirmed note=${result.note}');
        context.read<TripBloc>().add(
          TripEvent.cancelRequested(note: result.note),
        );
      }),
    );
  }

  void _showPassengerNoteSheet(BuildContext context, TripEntity trip) {
    printM('[ActiveTripBody] passenger note sheet opened');
    unawaited(
      PassengerNoteSheet.show(context, initialNote: trip.passengerNote).then((
        result,
      ) {
        if (result == null || !context.mounted) return;
        context.read<TripBloc>().add(
          TripEvent.passengerNoteSubmitted(result.note),
        );
      }),
    );
  }
}

extension on LatLng {
  DriverLocationEntity toDriverLocation(double bearing) {
    return DriverLocationEntity(
      latitude: latitude,
      longitude: longitude,
      bearing: bearing,
    );
  }
}

extension on TripStatus {
  bool get canEditPassengerNote =>
      this != TripStatus.inProgress &&
      !isTerminal &&
      this != TripStatus.unknown;
}
