part of 'itinerary_cubit.dart';

@immutable
abstract class ItineraryState {}

class ItineraryInitial extends ItineraryState {}
class SuccessGetOrdersState extends ItineraryState {}

class LoadingGetOrdersState extends ItineraryState {}

class FailureGetOrdersState extends ItineraryState {}
class SuccessOrderDetailsState extends ItineraryState {}
class LoadingOrderDetailsState extends ItineraryState {}
class FailureOrderDetailsState extends ItineraryState {}
class SuccessPartnetLatLongState extends ItineraryState {}
class LoadingPartnetLatLongState extends ItineraryState {}
class FailurePartnetLatLongState extends ItineraryState {}
