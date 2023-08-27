import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatelessWidget {
 final LatLng latLng;
  const GoogleMapScreen({Key? key,required this.latLng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(latLng.latitude,latLng.longitude),zoom: 13.5),
        markers: {
          Marker(markerId: MarkerId("target"),
          position: LatLng(latLng.latitude,latLng.longitude)
          ),
        },
      ),
    );
  }
}
