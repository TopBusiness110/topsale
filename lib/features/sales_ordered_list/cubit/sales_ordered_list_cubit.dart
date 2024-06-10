import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/all_partners_for_reports_model.dart';
import 'package:topsale/core/models/allusers_model.dart';
import 'package:topsale/core/models/get_all_orders.dart';
import 'package:topsale/core/models/get_partner_model.dart';
import 'package:topsale/core/models/order_details_model.dart';
import 'package:topsale/core/models/partner_latlong_model.dart';
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
  GetAllPartnersReportsModel? allUsersModel;
  getAllPartners({
    int pageId = 1,
    bool isGetMore = false,
  }) async {
    isGetMore
        ? emit(Loading2GetAllUsersState())
        : emit(LoadingGetAllUsersState());
    final response = await api.getAllPartnersForReport(pageId, 15);
    response.fold((l) {
      emit(FailureGetAllUsersState());
    }, (r) {
      if (isGetMore) {
        allUsersModel = GetAllPartnersReportsModel(
          count: r.count,
          next: r.next,
          prev: r.prev,
          result: [...allUsersModel!.result!, ...r.result!],
        );
      } else {
        allUsersModel = r;
      }
      emit(SuccessGetAllUsersState());
    });
  }

  double sumTax = 0;
  double totlalPrice = 0;
  GetOrderDetailsModel? getOrderDetailsModel;
  getOrderDetails(int? orderId) async {
    sumTax = 0;
    totlalPrice = 0;
    emit(LoadingOrderDetailsState());

    final response = await api.getOrderDetails(orderId!);
    response.fold((l) => emit(FailureOrderDetailsState()), (r) {
      emit(SuccessOrderDetailsState());
      r.result?.forEach((element) {
        sumTax += element.priceTax!;
        totlalPrice += element.priceTotal!;
      });
      getOrderDetailsModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }

  int skipped = 0;
  double totlalPriceForReports = 0;
  getOrderDetailss(int? orderId) async {
    emit(LoadingOrderDetailsState());

    final response = await api.getOrderDetails(orderId!);
    response.fold((l) => emit(FailureOrderDetailsState()), (r) {
      emit(SuccessOrderDetailsState());
      if (r.result!.isNotEmpty) {
        ordersListForReports.add(r);
      } else {
        skipped++;
      }
    });
  }

  String? getOrderName(String text) {
    RegExp regExp = RegExp(r'S\d+');

    String? code1 = regExp.firstMatch(text)?.group(0);
    return code1;
  }

  List<GetOrderDetailsModel> ordersListForReports = [];
  GetOrderDetailsModel? getOrderDetailsModelForReports;

  getOrderDetailsForReports(List<int>? ordersInt) async {
    totlalPriceForReports = 0;
    ordersListForReports = [];
    skipped = 0;
    emit(LoadingOrderDetailsState());

    ordersInt!.forEach((element) async {
      await getOrderDetailss(element);
    });

    print("ddddddddddddddddd" + "${ordersListForReports.length}");
    emit(SuccessOrderDetailsState());
  }

  GetPartnerLatLongModel? getPartnerLatLongModel;
  getPartnerName(int? partnerId) async {
    emit(LoadingPartnetLatLongState());
    final response = await api.getPartnerLatLong(partnerId!);
    response.fold((l) => emit(FailurePartnetLatLongState()), (r) {
      emit(SuccessPartnetLatLongState());
      getPartnerLatLongModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }

  GetPartnerDetailsModel? getPartnerDetailsModel;
  getPartnerDetails(int? partnerId) async {
    emit(LoadingPartnetLatLongState());
    final response = await api.getPartnerDetails(partnerId!);
    response.fold((l) => emit(FailurePartnetLatLongState()), (r) {
      emit(SuccessPartnetLatLongState());
      getPartnerDetailsModel = r;
      print("***************************************************");
      print(r.toString());
    });
  }

  searchInUser() {}
  GetAllOrdersModel? ordersModel;
  getAllOrders({
    int pageId = 1,
    bool isGetMore = false,
  }) async {
    emit(LoadingAllOrdersState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getAllSaleOrderForPartner(pageId, 15);
    response.fold((l) => emit(AllOrdersFailureState()), (r) {
      if (isGetMore) {
        ordersModel = GetAllOrdersModel(
          count: r.count,
          next: r.next,
          prev: r.prev,
          result: [...ordersModel!.result!, ...r.result!],
        );
      } else {
        ordersModel = r;
      }

      emit(AllOrdersSuccessState());

      //   r.result?.forEach((element) {});
    });
  }
}
