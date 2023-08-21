part of 'create_sales_order_cubit.dart';

@immutable
abstract class CreateSalesOrderState {}

class CreateSalesOrderInitial extends CreateSalesOrderState {}
class SelectingNameState extends CreateSalesOrderState {}
class SearchingResultsState extends CreateSalesOrderState {}
class AddingProductState extends CreateSalesOrderState {}
class AddingNewClient extends CreateSalesOrderState {}
class AddProductState extends CreateSalesOrderState {}
class RemoveProductState extends CreateSalesOrderState {}
class DeleteProductState extends CreateSalesOrderState {}
class CalculatingTotalPrice extends CreateSalesOrderState {}
class NoClientsMatchesState extends CreateSalesOrderState {}
