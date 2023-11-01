import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/sales_order_model.dart';

part 'returns_list_state.dart';

class ReturnsListCubit extends Cubit<ReturnsListState> {
  ReturnsListCubit() : super(ReturnsListInitial());
  List<SalesOrderModel?>? returnOrderedList = [];

  fillSalesOrderedList(
      {
        required DateTime creationDate,
        required  String customer,
        required String number,
        required  String status,
        required double total,
      }){
    returnOrderedList?.add(SalesOrderModel(
        creationDate:creationDate ,
        customer: customer,
        billingNumber:number ,
        status:status ,
        total: total
    ));
    emit(NewReturnOrderAdded());
  }
}
