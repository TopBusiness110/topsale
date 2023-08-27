import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:topsale/core/utils/app_colors.dart';

class GoogleMapRoutingScreen extends StatefulWidget {
  final LatLng destinationlatLng;
  const GoogleMapRoutingScreen({Key? key,required this.destinationlatLng}) : super(key: key);

  @override
  State<GoogleMapRoutingScreen> createState() => _GoogleMapRoutingScreenState();
}

class _GoogleMapRoutingScreenState extends State<GoogleMapRoutingScreen> {
  LocationData? currentLocation ;
  List<LatLng> polyLinesCoordinates = [];
  @override
  void initState() {
  getCurrentLocation();
  getPolyPoints();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(widget.destinationlatLng.latitude,widget.destinationlatLng.longitude),zoom: 13.5),
        markers: {
          Marker(markerId: MarkerId("client"),
              position: LatLng(widget.destinationlatLng.latitude,widget.destinationlatLng.longitude)
          ),
          Marker(markerId: MarkerId("current location"),
          position: LatLng(currentLocation?.latitude??31.008,currentLocation?.longitude??31.7754))
        },
        polylines: {
          Polyline(polylineId: PolylineId("route"),
              points: polyLinesCoordinates,
            color: AppColors.primary,
            width: 6
          )
        },
      ),
    );
  }
  getCurrentLocation()async{

    Location location = Location();
    location.getLocation().then((value) {
      currentLocation=value;
      print("++++++++++++++++++++++++++++++++++++++++");
      print(currentLocation);

    });

  }
  void getPolyPoints()async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult =await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyA6QI378BHt9eqBbiJKtqWHTSAZxcSwN3Q",
        PointLatLng(currentLocation?.latitude??30.666544, currentLocation?.longitude??31.998543),
        PointLatLng(widget.destinationlatLng.latitude, widget.destinationlatLng.longitude));
    if(polylineResult.points.isNotEmpty){
      polylineResult.points.forEach((element) {polyLinesCoordinates.add(LatLng(element.latitude, element.longitude));});
      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
      print(polyLinesCoordinates);
      setState(() {

      });
    }
  }
}
