import 'package:customertaxi/common/imports/imports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/core/theme/app_map_styles.dart';

class RootMapCanvasWidget extends StatelessWidget {
  const RootMapCanvasWidget({
    super.key,
    required this.currentLocation,
    required this.onMapCreated,
    this.tripPolylinePoints = const <LatLng>[],
    this.tripMarkers = const <Marker>{},
    this.onCameraMove,
    this.onCameraIdle,
    this.destinationLocation,
    this.showMyLocationButton = false,
  });

  final RootMapLocationEntity currentLocation;
  final void Function(GoogleMapController controller) onMapCreated;
  final List<LatLng> tripPolylinePoints;
  final Set<Marker> tripMarkers;
  final void Function(CameraPosition position)? onCameraMove;
  final VoidCallback? onCameraIdle;
  final LatLng? destinationLocation;
  final bool showMyLocationButton;

  LatLng get _latLng =>
      LatLng(currentLocation.latitude, currentLocation.longitude);

  Set<Marker> get _markers => <Marker>{...tripMarkers};

  Set<Polyline> _buildPolylines(BuildContext context) {
    printM('[RootMapCanvasWidget] _buildPolylines tripPoints=${tripPolylinePoints.length}');
    if (tripPolylinePoints.length < 2) {
      return const <Polyline>{};
    }

    final polylines = <Polyline>{};

    // 1. Walking path from Current Location to Trip Start (Dashed)
    polylines.add(
      Polyline(
        polylineId: const PolylineId('walking-to-start'),
        points: [_latLng, tripPolylinePoints.first],
        width: 3.r.toInt(),
        color: context.primary.withValues(alpha: 0.45),
        patterns: [PatternItem.dash(8), PatternItem.gap(6)],
      ),
    );

    // 2. Main Driving Path - Shadow (Thicker & Transparent)
    polylines.add(
      Polyline(
        polylineId: const PolylineId('order-trip-route-shadow'),
        points: tripPolylinePoints,
        width: 6.r.toInt(),
        color: context.primary.withValues(alpha: 0.15),
      ),
    );

    // 3. Main Driving Path (Solid - Primary)
    polylines.add(
      Polyline(
        polylineId: const PolylineId('order-trip-route'),
        points: tripPolylinePoints,
        width: 4.r.toInt(),
        color: context.primary,
      ),
    );

    // 4. Walking path from Trip End to Destination (Dashed)
    if (destinationLocation != null) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('walking-to-destination'),
          points: [tripPolylinePoints.last, destinationLocation!],
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
        onMapCreated: onMapCreated,
        onCameraMove: onCameraMove,
        onCameraIdle: onCameraIdle,
        initialCameraPosition: CameraPosition(
          target: _latLng,
          zoom: currentLocation.zoom,
        ),
        markers: _markers,
        polylines: _buildPolylines(context),
        myLocationEnabled: true,
        myLocationButtonEnabled: showMyLocationButton,
        compassEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        minMaxZoomPreference: const MinMaxZoomPreference(5, 19),
        ),
      ),
    );
  }
}
