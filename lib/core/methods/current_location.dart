

import 'package:location/location.dart';

Future<LocationData?>? getCurrentLocation()async{
  LocationData currentLocation ;
  Location location = Location();
  location.getLocation().then((value) {
    currentLocation=value;
    return currentLocation;
  });
  return null;
}