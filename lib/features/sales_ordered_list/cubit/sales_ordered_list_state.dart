part of 'sales_ordered_list_cubit.dart';

@immutable
abstract class SalesOrderedListState {}

class SalesOrderedListInitial extends SalesOrderedListState {}

class NewSalesOrderAdded extends SalesOrderedListState {}

class LoadingAllOrdersState extends SalesOrderedListState {}

class AllOrdersFailureState extends SalesOrderedListState {}

class AllOrdersSuccessState extends SalesOrderedListState {}
class LoadingGetAllUsersState extends SalesOrderedListState {}
class Loading2GetAllUsersState extends SalesOrderedListState {}
class SuccessGetAllUsersState extends SalesOrderedListState {}
class FailureGetAllUsersState extends SalesOrderedListState {}
class LoadingOrderDetailsState extends SalesOrderedListState {}
class FailureOrderDetailsState extends SalesOrderedListState {}
class SuccessOrderDetailsState extends SalesOrderedListState {}
class LoadingPartnetLatLongState extends SalesOrderedListState {}
class FailurePartnetLatLongState extends SalesOrderedListState {}
class SuccessPartnetLatLongState extends SalesOrderedListState {}