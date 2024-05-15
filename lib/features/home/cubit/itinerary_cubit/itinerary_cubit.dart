import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/get_orders_model.dart';
import 'package:topsale/core/models/order_details_model.dart';
import 'package:topsale/core/models/partner_latlong_model.dart';
import 'package:topsale/core/remote/service_api.dart';

part 'itinerary_state.dart';

class ItineraryCubit extends Cubit<ItineraryState> {
  ItineraryCubit(this.api) : super(ItineraryInitial());
  ServiceApi api;



  GetOrdersModel? getOrdersModel;
  getOrders() async {
    emit(LoadingGetOrdersState());
   
    final response = await api.getOrders(
     );
    response.fold((l) => emit(FailureGetOrdersState()), (r) {
      emit(SuccessGetOrdersState());
      getOrdersModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }
  GetOrderDetailsModel? getOrderDetailsModel;
  getOrderDetails(int orderId) async {
    emit(LoadingOrderDetailsState());
   
    final response = await api.getOrderDetails(orderId
     );
    response.fold((l) => emit(FailureOrderDetailsState()), (r) {
      emit(SuccessOrderDetailsState());
      getOrderDetailsModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }
  GetPartnerLatLongModel? getPartnerLatLongModel;
  getPartnerLatLong(int partnerId) async {
    emit(LoadingPartnetLatLongState());
    final response = await api.getPartnerLatLong(partnerId);
    response.fold((l) => emit(FailurePartnetLatLongState()), (r) {
      emit(SuccessPartnetLatLongState());
      getPartnerLatLongModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }



}
