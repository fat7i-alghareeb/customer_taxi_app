import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';

class RootMapCanvasWidget extends StatelessWidget {
  const RootMapCanvasWidget({
    super.key,
    required this.currentLocation,
    required this.onMapCreated,
  });


  final RootMapLocationEntity currentLocation;
  final void Function(GoogleMapController controller) onMapCreated;

  LatLng get _latLng =>
      LatLng(currentLocation.latitude, currentLocation.longitude);

  Set<Marker> get _markers => <Marker>{
    Marker(markerId: const MarkerId('current-location'), position: _latLng),
  };

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _latLng,
          zoom: currentLocation.zoom,
        ),
        markers: _markers,
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
