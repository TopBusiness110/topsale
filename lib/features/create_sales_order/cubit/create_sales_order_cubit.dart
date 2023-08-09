import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_sales_order_state.dart';

class CreateSalesOrderCubit extends Cubit<CreateSalesOrderState> {
  CreateSalesOrderCubit() : super(CreateSalesOrderInitial());
}
