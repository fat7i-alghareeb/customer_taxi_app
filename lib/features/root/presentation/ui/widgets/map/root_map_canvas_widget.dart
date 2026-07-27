import 'package:flutter/foundation.dart' show setEquals, listEquals;
import 'package:customertaxi/common/imports/imports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/trip/domain/entities/driver_location_entity.dart';
import 'package:customertaxi/core/theme/app_map_styles.dart';

class RootMapCanvasWidget extends StatefulWidget {
  const RootMapCanvasWidget({
    super.key,
    required this.currentLocation,
    required this.onMapCreated,
    this.legPolylines = const <List<LatLng>>[],
    this.tripMarkers = const <Marker>{},
    this.onCameraMove,
    this.onCameraIdle,
    this.destinationLocation,
    this.showMyLocationButton = false,
    this.driverLocation,
    this.driverMarkerIcon,
    this.pickupLocation,
    this.pickupRoute = const <LatLng>[],
  });

  final RootMapLocationEntity currentLocation;
  final void Function(GoogleMapController controller) onMapCreated;
  final List<List<LatLng>> legPolylines;
  final Set<Marker> tripMarkers;
  final void Function(CameraPosition position)? onCameraMove;
  final VoidCallback? onCameraIdle;
  final LatLng? destinationLocation;
  final bool showMyLocationButton;
  final DriverLocationEntity? driverLocation;
  final BitmapDescriptor? driverMarkerIcon;

  /// Pickup point the driver is heading to. When set together with
  /// [driverLocation], a line is drawn from the car to the pickup — used as a
  /// straight-line fallback until [pickupRoute] resolves.
  final LatLng? pickupLocation;

  /// Road-following route from the driver to the pickup (decoded directions).
  /// When non-empty it is drawn as the dashed orange path instead of a straight line.
  final List<LatLng> pickupRoute;

  @override
  State<RootMapCanvasWidget> createState() => _RootMapCanvasWidgetState();
}

class _RootMapCanvasWidgetState extends State<RootMapCanvasWidget> {
  Set<Marker>? _cachedMarkers;
  Set<Marker>? _lastTripMarkersInput;
  DriverLocationEntity? _lastDriverLocation;
  BitmapDescriptor? _lastDriverMarkerIcon;

  Set<Polyline>? _cachedPolylines;
  List<List<LatLng>>? _lastLegPolylinesInput;
  LatLng? _lastDestinationLocation;
  LatLng? _lastPickupLocation;
  List<LatLng>? _lastPickupRoute;
  bool? _lastIsDarkTheme;

  LatLng get _latLng => LatLng(
    widget.currentLocation.latitude,
    widget.currentLocation.longitude,
  );

  Set<Marker> _resolveMarkers() {
    if (_cachedMarkers != null &&
        setEquals(_lastTripMarkersInput, widget.tripMarkers) &&
        _lastDriverLocation == widget.driverLocation &&
        _lastDriverMarkerIcon == widget.driverMarkerIcon) {
      return _cachedMarkers!;
    }

    final markers = <Marker>{...widget.tripMarkers};
    if (widget.driverLocation != null && widget.driverMarkerIcon != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('active-driver-vehicle'),
          position: LatLng(
            widget.driverLocation!.latitude,
            widget.driverLocation!.longitude,
          ),
          icon: widget.driverMarkerIcon!,
          // The car is a side-view image kept upright on screen (default
          // rotation 0 / flat false); heading is conveyed by horizontally
          // flipping the icon (see ActiveTripBody), not by rotating the marker.
          anchor: const Offset(0.5, 0.5),
        ),
      );
    }

    _cachedMarkers = markers;
    _lastTripMarkersInput = widget.tripMarkers;
    _lastDriverLocation = widget.driverLocation;
    _lastDriverMarkerIcon = widget.driverMarkerIcon;
    return markers;
  }

  Set<Polyline> _resolvePolylines(BuildContext context) {
    final isDark = context.isDarkTheme;
    if (_cachedPolylines != null &&
        listEquals(_lastLegPolylinesInput, widget.legPolylines) &&
        _lastDriverLocation == widget.driverLocation &&
        _lastDestinationLocation == widget.destinationLocation &&
        _lastPickupLocation == widget.pickupLocation &&
        listEquals(_lastPickupRoute, widget.pickupRoute) &&
        _lastIsDarkTheme == isDark) {
      return _cachedPolylines!;
    }

    final polylines = _buildPolylines(context);

    _cachedPolylines = polylines;
    _lastLegPolylinesInput = widget.legPolylines;
    _lastDestinationLocation = widget.destinationLocation;
    _lastPickupLocation = widget.pickupLocation;
    _lastPickupRoute = widget.pickupRoute;
    _lastIsDarkTheme = isDark;
    return polylines;
  }

  Set<Polyline> _buildPolylines(BuildContext context) {
    final driverLocation = widget.driverLocation;
    final pickupRoute = widget.pickupRoute;
    final pickupLocation = widget.pickupLocation;
    final legPolylines = widget.legPolylines;
    final destinationLocation = widget.destinationLocation;
    final polylines = <Polyline>{};

    // Live dashed orange path from the driver's car to the pickup point.
    // Prefer the road-following route; fall back to a straight line until it loads.
    if (driverLocation != null && (pickupRoute.isNotEmpty || pickupLocation != null)) {
      final driverPos = LatLng(
        driverLocation.latitude,
        driverLocation.longitude,
      );
      final points = pickupRoute.isNotEmpty
          ? <LatLng>[driverPos, ...pickupRoute]
          : <LatLng>[driverPos, pickupLocation!];
      polylines.add(
        Polyline(
          polylineId: const PolylineId('driver-to-pickup'),
          points: points,
          width: 5.r.toInt(),
          color: Colors.orange,
          patterns: [PatternItem.dash(20), PatternItem.gap(12)],
        ),
      );
    }

    if (legPolylines.isEmpty) {
      return polylines;
    }

    // 1. Walking path from Current Location to Trip Start (Dashed)
    if (legPolylines.first.isNotEmpty) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('walking-to-start'),
          points: [_latLng, legPolylines.first.first],
          width: 3.r.toInt(),
          color: context.primary.withValues(alpha: 0.45),
          patterns: [PatternItem.dash(8), PatternItem.gap(6)],
        ),
      );
    }

    // The whole pickup → destination route carries the trip accent, one colour
    // across every leg: a multi-stop trip is still one journey, and the old
    // per-leg colour cycle read as several unrelated routes on the map. Stops
    // stay tellable apart by their markers.
    const color = AppColors.tripOrange;

    // 2. Render each leg
    for (int i = 0; i < legPolylines.length; i++) {
      final points = legPolylines[i];
      if (points.length < 2) continue;

      // Shadow
      polylines.add(
        Polyline(
          polylineId: PolylineId('order-trip-leg-$i-shadow'),
          points: points,
          width: 6.r.toInt(),
          color: color.withValues(alpha: 0.15),
        ),
      );

      // Solid
      polylines.add(
        Polyline(
          polylineId: PolylineId('order-trip-leg-$i'),
          points: points,
          width: 4.r.toInt(),
          color: color,
        ),
      );
    }

    // 4. Walking path from Trip End to Destination (Dashed)
    if (destinationLocation != null && legPolylines.last.isNotEmpty) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('walking-to-destination'),
          points: [legPolylines.last.last, destinationLocation],
          width: 3.r.toInt(),
          color: context.onSurface.withValues(alpha: 0.35),
          patterns: [PatternItem.dash(8), PatternItem.gap(6)],
        ),
      );
    }

    return polylines;
  }


  @override
  Widget build(BuildContext context) {
    printM('[RootMapCanvasWidget] build');
    return RepaintBoundary(
      // Avoid noisy Android accessibility logs from the map platform view.
      child: ExcludeSemantics(
        child: GoogleMap(
        style: context.isDarkTheme ? AppMapStyles.dark : null,
        onMapCreated: widget.onMapCreated,
        onCameraMove: widget.onCameraMove,
        onCameraIdle: widget.onCameraIdle,
        initialCameraPosition: CameraPosition(
          target: _latLng,
          zoom: widget.currentLocation.zoom,
        ),
        markers: _resolveMarkers(),
        polylines: _resolvePolylines(context),
        myLocationEnabled: true,
        myLocationButtonEnabled: widget.showMyLocationButton,
        compassEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        minMaxZoomPreference: const MinMaxZoomPreference(5, 19),
        ),
      ),
    );
  }
}
