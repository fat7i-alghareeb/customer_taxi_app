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
import 'package:customertaxi/features/trip/presentation/coordinators/trip_completion_coordinator.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/cancel_trip_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_cancelled_success_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/compensation_claim_dialog.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/completed_action_chips.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/passenger_note_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_fare_summary_card.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_rating_sheet.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_stops_timeline.dart';
import 'package:vibration/vibration.dart';

class ActiveTripBody extends StatefulWidget {
  const ActiveTripBody({super.key});

  @override
  State<ActiveTripBody> createState() => _ActiveTripBodyState();
}

class _ActiveTripBodyState extends State<ActiveTripBody>
    with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  BitmapDescriptor? _carMarkerIcon;
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
  TripStatus? _lastSeenTripStatus;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
    _primeArrivalGuardFromCurrentState();

    _carMovementController =
        AnimationController(
            vsync: this,
            duration:
                AppDurations.slow * 12, // Smooth interpolation over ~4 seconds
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
      final carIcon = await MapMarkerGenerator.createVehicleMarker(width: 80.r);
      final aIcon = await MapMarkerGenerator.createCustomMarker(
        text: 'A',
        color: Colors.orange,
        size: 45.r,
      );
      final bIcon = await MapMarkerGenerator.createCustomMarker(
        text: 'B',
        color: Colors.blue,
        size: 45.r,
      );

      if (mounted) {
        setState(() {
          _carMarkerIcon = carIcon;
          _pickupMarkerIcon = aIcon;
          _destinationMarkerIcon = bIcon;
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
        if (trip.status == TripStatus.driverArrived) {
          _arrivalAlertPlayed = true;
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

  Future<void> _handleTripCancelled(BuildContext context) async {
    final hasActiveTrip = getIt<ActiveTripCubit>().state.hasActiveTrip;
    if (!hasActiveTrip) return;

    await TripCancelledSuccessSheet.show(context);
    if (context.mounted) {
      context.read<OrderBloc>().add(
            const OrderEvent.collapseRequested(),
          );
      getIt<ActiveTripCubit>().clear();
    }
  }

  void _handleTripStateChange(BuildContext context, TripState state) {
    state.tripStatus.whenOrNull(
      success: (trip) {
        printC('[ActiveTripBody] trip state changed status=${trip.status}');
        if (trip.status == TripStatus.cancelled) {
          unawaited(_handleTripCancelled(context));
          return;
        }

        final isRealTransitionToArrived =
            _lastSeenTripStatus != TripStatus.driverArrived &&
            trip.status == TripStatus.driverArrived;
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
              failure: (msg) {
                // A failed cancellation just surfaces the error. (Compensation
                // claims are a separate flow reached from the late-driver action,
                // not a consequence of a cancel failure.)
                showErrorOverlay(context, msg);
              },
            );
          },
        ),
        BlocListener<TripBloc, TripState>(
          listenWhen: (prev, curr) =>
              prev.compensationClaimStatus != curr.compensationClaimStatus,
          listener: (context, state) {
            state.compensationClaimStatus.whenOrNull(
              success: (_) => showSuccessOverlay(
                context,
                AppStrings.compensationClaimSubmitted,
              ),
              failure: (msg) => showSuccessOverlay(context, msg),
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

              return Stack(
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
                    driverLocation: _currentCarPosition?.toDriverLocation(
                      _interpolatedBearing,
                    ),
                    driverMarkerIcon: _carMarkerIcon,
                  ),

                  // Glassmorphic Premium Dark Sheet Overlay at bottom
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child:
                        _GlassmorphicTripStatusSheet(
                              trip: trip,
                              cancelStatus: state.cancelStatus,
                              onCancelPressed: () => _showCancelDialog(context),
                              onCompensationPressed: () =>
                                  _showCompensationClaimDialog(context),
                            )
                            .animate()
                            .fadeIn(duration: 350.ms)
                            .slideY(
                              begin: 0.2,
                              end: 0.0,
                              duration: 350.ms,
                              curve: Curves.easeOutCubic,
                            ),
                  ),
                  if (canEditPassengerNote)
                    PositionedDirectional(
                      end: AppSpacing.xl.w,
                      bottom: 245.h + MediaQuery.paddingOf(context).bottom,
                      child: _PassengerNoteFloatingAction(
                        hasNote: trip.passengerNote?.trim().isNotEmpty == true,
                        isLoading: state.passengerNoteStatus.isLoading,
                        onTap: () => _showPassengerNoteSheet(context, trip),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    printM('[ActiveTripBody] cancel sheet opened');
    unawaited(
      CancelTripSheet.show(context).then((result) {
        if (result == null || !context.mounted) return;
        printM('[ActiveTripBody] cancel confirmed note=${result.note}');
        context.read<TripBloc>().add(
          TripEvent.cancelRequested(note: result.note),
        );
      }),
    );
  }

  void _showCompensationClaimDialog(BuildContext context) {
    printM('[ActiveTripBody] compensation claim dialog opened');
    unawaited(
      CompensationClaimDialog.show(context).then((result) {
        if (result == null || !context.mounted) return;

        printM('[ActiveTripBody] compensation claim submitted');
        context.read<TripBloc>().add(
          TripEvent.compensationClaimSubmitted(
            note: result.note,
            evidenceUrls: result.evidenceUrls,
          ),
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

class _PassengerNoteFloatingAction extends StatelessWidget {
  const _PassengerNoteFloatingAction({
    required this.hasNote,
    required this.isLoading,
    required this.onTap,
  });

  final bool hasNote;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        child: Ink(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.25),
                blurRadius: 18.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                SizedBox(
                  width: 16.r,
                  height: 16.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.r,
                    valueColor: AlwaysStoppedAnimation<Color>(colors.onPrimary),
                  ),
                )
              else
                FaIcon(
                  hasNote
                      ? FontAwesomeIcons.solidComment
                      : FontAwesomeIcons.message,
                  size: 16.r,
                  color: colors.onPrimary,
                ),
              AppSpacing.sm.horizontalSpace,
              Text(
                AppStrings.passengerNoteEdit,
                style: AppTextStyles.s12w700.copyWith(color: colors.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassmorphicTripStatusSheet extends StatefulWidget {
  const _GlassmorphicTripStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
    required this.onCompensationPressed,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;
  final VoidCallback onCompensationPressed;

  @override
  State<_GlassmorphicTripStatusSheet> createState() =>
      _GlassmorphicTripStatusSheetState();
}

class _GlassmorphicTripStatusSheetState
    extends State<_GlassmorphicTripStatusSheet> {
  // Drives the 1-second rebuilds for the live waiting countdown while the
  // driver is waiting at pickup.
  Timer? _waitingTicker;
  // Ensures the post-trip rating sheet is only auto-shown once.
  bool _ratingPrompted = false;

  TripEntity get trip => widget.trip;
  BlocStatus<void> get cancelStatus => widget.cancelStatus;
  VoidCallback get onCancelPressed => widget.onCancelPressed;
  VoidCallback get onCompensationPressed => widget.onCompensationPressed;

  @override
  void initState() {
    super.initState();
    _syncWaitingTicker();
    _maybePromptRating();
  }

  @override
  void didUpdateWidget(covariant _GlassmorphicTripStatusSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncWaitingTicker();
    _maybePromptRating();
  }

  @override
  void dispose() {
    _waitingTicker?.cancel();
    super.dispose();
  }

  void _syncWaitingTicker() {
    final needsTicker = trip.status == TripStatus.driverArrived;
    if (needsTicker && _waitingTicker == null) {
      _waitingTicker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    } else if (!needsTicker && _waitingTicker != null) {
      _waitingTicker?.cancel();
      _waitingTicker = null;
    }
  }

  void _maybePromptRating() {
    if (_ratingPrompted || trip.status != TripStatus.completed) return;
    _ratingPrompted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        getIt<TripCompletionCoordinator>().promptRatingForCompletedTrip(
          trip.id,
        ),
      );
    });
  }

  Future<void> _refreshActiveTripGate() async {
    await getIt<ActiveTripCubit>().refresh();
  }

  Future<void> _clearActiveTripGate() async {
    final cubit = getIt<ActiveTripCubit>();
    cubit.clear();
    await cubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xl.r)),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.85),
            border: Border(
              top: BorderSide(
                color: colors.onSurface.withValues(alpha: 0.08),
                width: 1.5.r,
              ),
            ),
          ),
          padding: REdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl,
            AppSpacing.xl + bottomPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tiny top drag handle visual styling
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: colors.onSurface.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadii.sm.r),
                  ),
                ),
              ),
              AppSpacing.md.verticalSpace,

              // Glassmorphic status specific cards builder
              if (trip.status == TripStatus.driverEnRoute) ...[
                _buildEnRouteSheet(context),
              ] else if (trip.status == TripStatus.driverArrived) ...[
                _buildArrivedSheet(context),
              ] else if (trip.status == TripStatus.inProgress) ...[
                _buildInProgressSheet(context),
              ] else if (trip.status == TripStatus.completed) ...[
                _buildCompletedSheet(context),
              ] else ...[
                // Default fallback
                _buildGeneralSheet(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnRouteSheet(BuildContext context) {
    final colors = context.colorScheme;
    final int etaMins = trip.etaToPickup != null
        ? trip.etaToPickup!.difference(DateTime.now()).inMinutes
        : 5;
    final displayEta = etaMins > 0 ? etaMins : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.carSide, color: colors.primary, size: 24.r),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.tripStatusDriverEnRoute,
                style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
              ),
            ),
            Container(
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadii.sm.r),
              ),
              child: Text(
                AppStrings.activeTripLiveEta.replaceAll(
                  '{time}',
                  '$displayEta min',
                ),
                style: AppTextStyles.s12w700.copyWith(color: colors.primary),
              ),
            ),
          ],
        ),
        AppSpacing.lg.verticalSpace,

        // Beautiful Orange/White Vehicle details banner
        _buildVehicleCard(context),
        AppSpacing.xl.verticalSpace,

        // Cancel button
        AppButton.outline(
          variant: AppButtonVariant.error,
          isLoading: cancelStatus.isLoading,
          onTap: onCancelPressed,
          child: AppButtonChild.label(AppStrings.activeTripCancelRide),
        ),
      ],
    );
  }

  Widget _buildArrivedSheet(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Prominent glowing green highlight banner
        Container(
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.3),
              width: 1.r,
            ),
          ),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.solidCircleCheck,
                color: AppColors.success,
                size: 28.r,
              ).animate().scale(duration: 400.ms),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.tripStatusDriverArrived,
                      style: AppTextStyles.s14w700.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      AppStrings.activeTripDriverOutside,
                      style: AppTextStyles.s16w700.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpacing.lg.verticalSpace,

        // Live "board within 10 minutes" countdown + accruing waiting fee.
        _buildWaitingCountdown(context),

        // Vehicle info
        _buildVehicleCard(context),
        AppSpacing.xl.verticalSpace,

        // Cancel button
        AppButton.outline(
          variant: AppButtonVariant.error,
          isLoading: cancelStatus.isLoading,
          onTap: onCancelPressed,
          child: AppButtonChild.label(AppStrings.activeTripCancelRide),
        ),

        // Late-driver compensation claim (policy: >20 min late => 5% back).
        AppSpacing.sm.verticalSpace,
        Center(
          child: TextButton(
            onPressed: onCompensationPressed,
            child: Text(AppStrings.activeTripReportDriverLate),
          ),
        ),
      ],
    );
  }

  /// Shows the 10-minute boarding countdown after the driver arrives. Once the
  /// free grace window elapses, it switches to the accruing per-minute fee.
  Widget _buildWaitingCountdown(BuildContext context) {
    final colors = context.colorScheme;
    final session = trip.activeWaitingSession;
    final startUtc = session?.startedAtUtc ?? trip.arrivedAtUtc;
    if (startUtc == null) return const SizedBox.shrink();

    final graceMinutes = session?.graceMinutes ?? 10;
    final ratePerMinute = session?.ratePerMinute ?? 0;
    final elapsed = DateTime.now().difference(startUtc);
    final graceRemaining = Duration(minutes: graceMinutes) - elapsed;

    final Widget content;
    final Color tint;
    if (graceRemaining > Duration.zero) {
      final mm = graceRemaining.inMinutes
          .remainder(60)
          .toString()
          .padLeft(2, '0');
      final ss = graceRemaining.inSeconds
          .remainder(60)
          .toString()
          .padLeft(2, '0');
      tint = colors.primary;
      content = Row(
        children: [
          FaIcon(FontAwesomeIcons.solidClock, color: tint, size: 18.r),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Text(
              AppStrings.tripArrivedBoardWithin.replaceAll('{time}', '$mm:$ss'),
              style: AppTextStyles.s14w700.copyWith(color: colors.onSurface),
            ),
          ),
        ],
      );
    } else {
      final overdueSeconds = elapsed.inSeconds - graceMinutes * 60;
      final billableMinutes = (overdueSeconds / 60).ceil();
      final fee = billableMinutes * ratePerMinute;
      final amount = '${fee.toStringAsFixed(2)} ${trip.currencyCode}';
      tint = AppColors.warning;
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.triangleExclamation,
                color: tint,
                size: 18.r,
              ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Text(
                  AppStrings.tripWaitingGraceOver,
                  style: AppTextStyles.s12w500.copyWith(
                    color: colors.onSurface,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.xs.verticalSpace,
          Text(
            AppStrings.tripWaitingFeeAccruing.replaceAll('{amount}', amount),
            style: AppTextStyles.s16w700.copyWith(color: tint),
          ),
        ],
      );
    }

    return Padding(
      padding: REdgeInsets.only(bottom: AppSpacing.lg),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadii.lg.r),
          border: Border.all(color: tint.withValues(alpha: 0.30), width: 1.r),
        ),
        child: content,
      ),
    );
  }

  Widget _buildInProgressSheet(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.route, color: colors.primary, size: 24.r),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.tripStatusInProgress,
                style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
              ),
            ),
          ],
        ),
        AppSpacing.lg.verticalSpace,

        // Ride details in-progress (vehicle type only, NO profile leaks)
        _buildVehicleCard(context),
        AppSpacing.xl.verticalSpace,

        // Informational row (no cancel button since ride is active!)
        Center(
          child: Text(
            AppStrings.yourJourneyBeginsHere,
            style: AppTextStyles.s14w400.copyWith(
              color: colors.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedSheet(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: FaIcon(
            FontAwesomeIcons.circleCheck,
            color: AppColors.success,
            size: 48.r,
          ),
        ),
        AppSpacing.md.verticalSpace,
        Center(
          child: Text(
            AppStrings.tripStatusCompleted,
            style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
          ),
        ),
        AppSpacing.lg.verticalSpace,

        // Uber-style receipt / invoice chips
        CompletedActionChips(tripId: trip.id),
        AppSpacing.lg.verticalSpace,

        // Fare Summary Card
        TripFareSummaryCard(
          amount: trip.quotedFare,
          currencyCode: trip.currencyCode,
          referenceCode: trip.referenceCode,
        ),
        AppSpacing.xl.verticalSpace,

        // Stops Timeline
        if (trip.stops.isNotEmpty) ...[
          TripStopsTimeline(stops: trip.stops),
          AppSpacing.xl.verticalSpace,
        ],

        // Rate the trip (also auto-shown once on completion).
        AppButton.outline(
          onTap: () => showTripRatingSheet(
            context,
            tripId: trip.id,
            onClosed: _refreshActiveTripGate,
          ),
          child: AppButtonChild.label(AppStrings.ratingTitle),
        ),
        AppSpacing.md.verticalSpace,

        // Done button to route home (explicit dismiss — no auto-redirect)
        AppButton.primaryGradient(
          onTap: () async {
            await _clearActiveTripGate();
            if (context.mounted) context.goNamed('RootScreen');
          },
          child: AppButtonChild.label(AppStrings.done),
        ),
      ],
    );
  }

  Widget _buildGeneralSheet(BuildContext context) {
    final colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.circleInfo,
              color: colors.primary,
              size: 24.r,
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Text(
                trip.status.name.toUpperCase(),
                style: AppTextStyles.s20w700.copyWith(color: colors.onSurface),
              ),
            ),
          ],
        ),
        AppSpacing.xl.verticalSpace,

        if (trip.status.canCancel)
          AppButton.outline(
            variant: AppButtonVariant.error,
            isLoading: cancelStatus.isLoading,
            onTap: onCancelPressed,
            child: AppButtonChild.label(AppStrings.activeTripCancelRide),
          ),
      ],
    );
  }

  Widget _buildVehicleCard(BuildContext context) {
    final colors = context.colorScheme;
    final vehicleType = trip.vehicleTypeName?.trim().isNotEmpty == true
        ? trip.vehicleTypeName!.trim()
        : AppStrings.carType;
    final vehicleString = AppStrings.activeTripLookForCar.replaceAll(
      '{type}',
      vehicleType,
    );

    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: colors.onSurface.withValues(alpha: 0.06),
          width: 1.r,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: REdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              FontAwesomeIcons.car,
              color: colors.primary,
              size: 24.r,
            ),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicleType,
                  style: AppTextStyles.s16w700.copyWith(
                    color: colors.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  vehicleString,
                  style: AppTextStyles.s12w400.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
