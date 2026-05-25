import 'dart:ui' as ui;
import 'package:flutter/services.dart' show SystemSound, SystemSoundType;
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
import 'package:customertaxi/features/trip/presentation/states/trip_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();

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

  void _handleTripStateChange(BuildContext context, TripState state) {
    state.cancelStatus.whenOrNull(
      failure: (msg) {
        showSuccessOverlay(context, msg);
        _showCompensationClaimDialog(context);
      },
    );
    state.compensationClaimStatus.whenOrNull(
      success: (_) => showSuccessOverlay(
        context,
        AppStrings.compensationClaimSubmitted,
      ),
      failure: (msg) => showSuccessOverlay(context, msg),
    );

    state.tripStatus.whenOrNull(
      success: (trip) {
        printC('[ActiveTripBody] trip state changed status=${trip.status}');
        if (trip.status == TripStatus.driverArrived) {
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

        if (trip.status.isTerminal) {
          printG('[ActiveTripBody] terminal trip, returning to root soon');
          Future.delayed(AppDurations.slow * 4, () {
            if (context.mounted) context.goNamed('RootScreen');
          });
        }
      },
    );
  }

  Set<Marker> _buildTripMarkers(TripEntity trip) {
    final markers = <Marker>{};
    if (trip.stops.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId('trip-pickup-point'),
          position: LatLng(
            trip.stops.first.latitude,
            trip.stops.first.longitude,
          ),
          icon:
              _pickupMarkerIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );

      if (trip.stops.length > 1) {
        markers.add(
          Marker(
            markerId: const MarkerId('trip-destination-point'),
            position: LatLng(
              trip.stops.last.latitude,
              trip.stops.last.longitude,
            ),
            icon:
                _destinationMarkerIcon ??
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      }
    }
    return markers;
  }

  List<List<LatLng>> _buildRoutePolylines(TripEntity trip) {
    final List<LatLng> points = trip.stops
        .map((s) => LatLng(s.latitude, s.longitude))
        .toList();
    return points.isNotEmpty ? [points] : const <List<LatLng>>[];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripBloc, TripState>(
      listenWhen: (prev, curr) =>
          prev.cancelStatus != curr.cancelStatus ||
          prev.tripStatus != curr.tripStatus ||
          prev.activeDriverLocation != curr.activeDriverLocation,
      listener: _handleTripStateChange,
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
              ],
            );
          },
        );
      },
    );
  }

  void _showCancelDialog(BuildContext context) {
    printM('[ActiveTripBody] cancel dialog opened');
    unawaited(
      AppDialog.show<bool>(
        context,
        dialog: AppDialog.basic(
          title: AppStrings.tripCancelButton,
          message: AppStrings.cancellationPolicyCancelDialog,
          secondaryAction: AppDialogAction.secondary(
            label: AppStrings.cancel,
            onPressed: () => Navigator.pop(context, false),
          ),
          primaryAction: AppDialogAction.danger(
            label: AppStrings.confirm,
            onPressed: () => Navigator.pop(context, true),
          ),
        ),
      ).then((confirmed) {
        if (confirmed == true && context.mounted) {
          printM('[ActiveTripBody] cancel confirmed');
          context.read<TripBloc>().add(const TripEvent.cancelRequested());
        }
      }),
    );
  }

  void _showCompensationClaimDialog(BuildContext context) {
    final controller = TextEditingController();
    printM('[ActiveTripBody] compensation claim dialog opened');
    unawaited(
      showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(AppStrings.reportDriverDelay),
          content: TextField(
            controller: controller,
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: AppStrings.compensationClaimNoteHint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(AppStrings.confirm),
            ),
          ],
        ),
      ).then((confirmed) {
        final note = controller.text.trim();
        controller.dispose();
        if (confirmed == true && context.mounted && note.isNotEmpty) {
          printM('[ActiveTripBody] compensation claim submitted');
          context.read<TripBloc>().add(
            TripEvent.compensationClaimSubmitted(note: note),
          );
        }
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

class _GlassmorphicTripStatusSheet extends StatelessWidget {
  const _GlassmorphicTripStatusSheet({
    required this.trip,
    required this.cancelStatus,
    required this.onCancelPressed,
  });

  final TripEntity trip;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onCancelPressed;

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
      ],
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
    final fareStr =
        '${trip.quotedFare.toStringAsFixed(2)} ${trip.currencyCode}';

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

        // Fare Summary Card
        Container(
          padding: REdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: colors.onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
          ),
          child: Column(
            children: [
              Text(
                AppStrings.tripFare.replaceAll('{fare} {currency}', fareStr),
                style: AppTextStyles.s24w700.copyWith(color: colors.primary),
              ),
              AppSpacing.xs.verticalSpace,
              Text(
                AppStrings.tripReferenceCode.replaceAll(
                  '#{code}',
                  trip.referenceCode,
                ),
                style: AppTextStyles.s12w400.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.xl.verticalSpace,

        // Done button to route home
        AppButton.primaryGradient(
          onTap: () => context.goNamed('RootScreen'),
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
