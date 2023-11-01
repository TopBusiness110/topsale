import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/sales_order_model.dart';

part 'sales_ordered_list_state.dart';

class SalesOrderedListCubit extends Cubit<SalesOrderedListState> {
  SalesOrderedListCubit() : super(SalesOrderedListInitial());
  List<SalesOrderModel?>? salesOrderedList = [];

  fillSalesOrderedList(
      {
        required DateTime creationDate,
        required  String customer,
       required String number,
        required  String status,
        required double total,
      }){
    salesOrderedList?.add(SalesOrderModel(
      creationDate:creationDate ,
      customer: customer,
      billingNumber:number ,
      status:status ,
      total: total
    ));
    emit(NewSalesOrderAdded());
  }
}
