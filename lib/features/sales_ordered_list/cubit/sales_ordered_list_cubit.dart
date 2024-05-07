import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/allusers_model.dart';
import 'package:topsale/core/models/get_all_orders.dart';
import 'package:topsale/core/remote/service_api.dart';

import '../../../core/models/sales_order_model.dart';

part 'sales_ordered_list_state.dart';

class SalesOrderedListCubit extends Cubit<SalesOrderedListState> {
  SalesOrderedListCubit(this.api) : super(SalesOrderedListInitial());
  ServiceApi api;

  List<SalesOrderModel?>? salesOrderedList = [];
  List<UsersList> matches = [];
  fillSalesOrderedList({
    required DateTime creationDate,
    required String customer,
    required String number,
    required String status,
    required double total,
  }) {
    salesOrderedList?.add(SalesOrderModel(
        creationDate: creationDate,
        customer: customer,
        billingNumber: number,
        status: status,
        total: total));
    emit(NewSalesOrderAdded());
  }


  AllUsersModel? allUsersModel;
  getAllUsers({
    int pageId = 1,
    bool isGetMore = false,
  }) async {
    isGetMore
        ? emit(Loading2GetAllUsersState())
        : emit(LoadingGetAllUsersState());
    matches.clear();
  
    final response = await api.getAllUsers(pageId,1000);
    response.fold((l) {
      emit(FailureGetAllUsersState());
    }, (r) {

if (isGetMore) {
        allUsersModel = AllUsersModel(
          count: r.count,
          next: r.next,
          
          prev: r.prev,
          result: [...allUsersModel!.result!, ...r.result!],
        );
      } else {
        allUsersModel = r;
      }



      
      matches.addAll(allUsersModel!.result!);
      emit(SuccessGetAllUsersState());
    });
  }


  searchInUser() {}
  GetAllOrdersModel? ordersModel;
  getAllOrders() async {
    emit(LoadingAllOrdersState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getAllSaleOrderForPartner();
    response.fold((l) => emit(AllOrdersFailureState()), (r) {
      emit(AllOrdersSuccessState());
      ordersModel = r;
      r.result?.forEach((element) {});

      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }
}
