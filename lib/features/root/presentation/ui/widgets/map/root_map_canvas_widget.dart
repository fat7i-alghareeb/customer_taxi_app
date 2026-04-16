import 'package:customertaxi/common/imports/imports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';

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
  });

  final RootMapLocationEntity currentLocation;
  final void Function(GoogleMapController controller) onMapCreated;
  final List<LatLng> tripPolylinePoints;
  final Set<Marker> tripMarkers;
  final void Function(CameraPosition position)? onCameraMove;
  final VoidCallback? onCameraIdle;
  final LatLng? destinationLocation;

  LatLng get _latLng =>
      LatLng(currentLocation.latitude, currentLocation.longitude);

  Set<Marker> get _markers => <Marker>{...tripMarkers};

  Set<Polyline> _buildPolylines(BuildContext context) {
    if (tripPolylinePoints.length < 2) {
      return const <Polyline>{};
    }

    final polylines = <Polyline>{};

    // 1. Walking path from Current Location to Trip Start (Dashed)
    polylines.add(
      Polyline(
        polylineId: const PolylineId('walking-to-start'),
        points: [_latLng, tripPolylinePoints.first],
        width: 3,
        color: context.primary.withValues(alpha: 0.5),
        patterns: [PatternItem.dash(10), PatternItem.gap(10)],
      ),
    );

    // 2. Main Driving Path (Solid - Bolder Black)
    polylines.add(
      Polyline(
        polylineId: const PolylineId('order-trip-route'),
        points: tripPolylinePoints,
        width: 8.r.toInt(),
      ),
    );

    // 3. Walking path from Trip End to Destination (Dashed)
    if (destinationLocation != null) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('walking-to-destination'),
          points: [tripPolylinePoints.last, destinationLocation!],
          width: 4.r.toInt(),
          color: Colors.black54,
          patterns: [PatternItem.dash(10), PatternItem.gap(10)],
        ),
      );
    }

    return polylines;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GoogleMap(
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
        myLocationButtonEnabled: false,
        compassEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        minMaxZoomPreference: const MinMaxZoomPreference(5, 19),
      ),
    );
  }
}
