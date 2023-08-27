import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'itinerary_state.dart';

class ItineraryCubit extends Cubit<ItineraryState> {
  ItineraryCubit() : super(ItineraryInitial());

}
