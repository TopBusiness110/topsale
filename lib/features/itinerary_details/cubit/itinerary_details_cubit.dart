import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
part 'itinerary_details_state.dart';


class ItineraryDetailsCubit extends Cubit<ItineraryDetailsState> {
  ItineraryDetailsCubit() : super(ItineraryDetailsInitial());
  final ImagePicker picker = ImagePicker();
  TextEditingController reasonController = TextEditingController();
  // Capture a photo.
   XFile? photo ;
  DateTime? startDateTime ;
  DateTime? endDateTime;
  DateTime? cancelDateTime ;

  LatLng? startLatLng;
  LatLng? endLatLng;
  LatLng? cancelLatLng;

  takePhoto() async {
    photo =  await picker.pickImage(source: ImageSource.camera);
    emit(PhotoSuccessState());
  }

}
