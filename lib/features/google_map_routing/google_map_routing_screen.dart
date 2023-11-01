import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
//import 'package:google_maps_webservice/directions.dart';

class GoogleMapRoutingScreen extends StatefulWidget {
  final LatLng destinationlatLng;

  const GoogleMapRoutingScreen({Key? key, required this.destinationlatLng})
      : super(key: key);

  @override
  State<GoogleMapRoutingScreen> createState() => _GoogleMapRoutingScreenState();
}

class _GoogleMapRoutingScreenState extends State<GoogleMapRoutingScreen> {
  Set<Marker> markers = Set(); //markers for google map

  LatLng startLocation = LatLng(27.6683619, 85.3101895);
  LatLng endLocation = LatLng(27.6688312, 85.3077329);
  LocationData? currentLocation;

  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCqeB0JnSmNrrtuICRJEG3ZJPxC1DLWSmU";
  Map<PolylineId, Polyline> polylines = {};

//***********************************************************************************
  // List<LatLng> polylineCoordinates = [];
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.destinationlatLng.latitude,
                widget.destinationlatLng.longitude),
            zoom: 13.5),
        markers: markers,
        // {
        //   Marker(markerId: MarkerId("client"),
        //       infoWindow: InfoWindow( //popup info
        //         title: 'Starting Point ',
        //         snippet: 'Start Marker',
        //       ),
        //       icon: BitmapDescriptor.defaultMarker,
        //       position: LatLng(widget.destinationlatLng.latitude,
        //           widget.destinationlatLng.longitude)
        //   ),
        //   Marker(markerId: MarkerId("current location"),
        //       infoWindow: InfoWindow( //popup info
        //         title: 'Destination Point ',
        //         snippet: 'Destination Marker',
        //       ),
        //       icon: BitmapDescriptor.defaultMarker,
        //       position: LatLng(currentLocation?.latitude ?? 31.008,
        //           currentLocation?.longitude ?? 31.7754))
        // },

        onMapCreated: (GoogleMapController controller) {
          // Map controller is ready
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((value) {
      currentLocation = value;
      print("++++++++++++++++++++++++++++++++++++++++");
      print(currentLocation);
    });
  }

  void getPolyPoints() async {
    startLocation = LatLng(
        widget.destinationlatLng.latitude, widget.destinationlatLng.longitude);
    endLocation = LatLng(currentLocation?.latitude ?? 31.008,
        currentLocation?.longitude ?? 31.7754);
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
    // PolylinePoints polylinePoints = PolylinePoints();
    // PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
    //   "AIzaSyCqeB0JnSmNrrtuICRJEG3ZJPxC1DLWSmU",
    //
    //   PointLatLng(
    //     currentLocation?.latitude ?? 30.666544,
    //     currentLocation?.longitude ?? 31.998543,
    //   ),
    //   PointLatLng(
    //     widget.destinationlatLng.latitude,
    //     widget.destinationlatLng.longitude,
    //   ),// Replace with your Google Maps API key
    //   travelMode: TravelMode.driving,
    //
    //
    // );
    //
    // if (polylineResult.points.isNotEmpty) {
    //   polyLinesCoordinates.clear(); // Clear the list each time
    //   polylineResult.points.forEach((element) {
    //     polyLinesCoordinates.add(LatLng(element.latitude, element.longitude));
    //   });
    //   print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    //   print(polyLinesCoordinates);
    //   setState(() {
    //     _polylines.clear();
    //     _polylines.add(
    //       Polyline(
    //         polylineId: PolylineId('route'),
    //         color: Colors.red,
    //         points: polyLinesCoordinates,
    //       ),
    //     );
    //   });
    // }
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }
//
// void getPolyPoints() async {
//   PolylinePoints polylinePoints = PolylinePoints();
//   PolylineResult polylineResult = await polylinePoints
//       .getRouteBetweenCoordinates(
//       "AIzaSyCqeB0JnSmNrrtuICRJEG3ZJPxC1DLWSmU",
//       travelMode: TravelMode.driving,
//
//       PointLatLng(currentLocation?.latitude ?? 30.666544,
//           currentLocation?.longitude ?? 31.998543),
//       PointLatLng(widget.destinationlatLng.latitude,
//           widget.destinationlatLng.longitude));
//
//   if (polylineResult.points.isNotEmpty) {
//     polylineResult.points.forEach((element) {
//       polyLinesCoordinates.add(LatLng(element.latitude, element.longitude));
//     });
//     print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
//     print(polyLinesCoordinates);
//     setState(() {
//
//       _polylines.clear();
//       _polylines.add(
//         Polyline(
//           polylineId: PolylineId('route'),
//           color: Colors.blue,
//           points: polyLinesCoordinates,
//         ),
//       );
//     });
//   }
// }

// void drawRoute(GoogleMapController controller) {
//   Polyline polyline = Polyline(
//     polylineId: PolylineId('route'),
//     color: Colors.blue,
//     width: 3,
//     points: polyLinesCoordinates
//   );
// }
}
