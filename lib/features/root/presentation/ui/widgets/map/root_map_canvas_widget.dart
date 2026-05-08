import 'package:customertaxi/common/imports/imports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/core/theme/app_map_styles.dart';

class RootMapCanvasWidget extends StatelessWidget {
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
  });

  final RootMapLocationEntity currentLocation;
  final void Function(GoogleMapController controller) onMapCreated;
  final List<List<LatLng>> legPolylines;
  final Set<Marker> tripMarkers;
  final void Function(CameraPosition position)? onCameraMove;
  final VoidCallback? onCameraIdle;
  final LatLng? destinationLocation;
  final bool showMyLocationButton;

  LatLng get _latLng =>
      LatLng(currentLocation.latitude, currentLocation.longitude);

  Set<Marker> get _markers => <Marker>{...tripMarkers};

  Set<Polyline> _buildPolylines(BuildContext context) {
    if (legPolylines.isEmpty) {
      return const <Polyline>{};
    }

    final polylines = <Polyline>{};

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

    // Colors for legs
    final legColors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
    ];

    // 2. Render each leg
    for (int i = 0; i < legPolylines.length; i++) {
      final points = legPolylines[i];
      if (points.length < 2) continue;

      final color = legColors[i % legColors.length];

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
          points: [legPolylines.last.last, destinationLocation!],
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
