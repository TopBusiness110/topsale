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

class LoadingGetAllUsersState extends CreateSalesOrderState {}

class Loading2GetAllUsersState extends CreateSalesOrderState {}

class SuccessGetAllUsersState extends CreateSalesOrderState {}

class FailureGetAllUsersState extends CreateSalesOrderState {}

class LoadingCreateSaleOrderState extends CreateSalesOrderState {}

class SuccessCreateSaleOrderState extends CreateSalesOrderState {}

class FailureCreateSaleOrderState extends CreateSalesOrderState {}

class LoadingCreateSaleOrderLineState extends CreateSalesOrderState {}

class SuccessCreateSaleOrderLineState extends CreateSalesOrderState {}

class FailureCreateSaleOrderLineState extends CreateSalesOrderState {}

class LoadingGetJournalsState extends CreateSalesOrderState {}

class SuccessGetJournalsState extends CreateSalesOrderState {}

class FailureGetJournalsState extends CreateSalesOrderState {}

class LoadingOrderRelationState extends CreateSalesOrderState {}

class SuccessOrderRelationState extends CreateSalesOrderState {}

class FailureOrderRelationState extends CreateSalesOrderState {}

class LoadingConfirmInvoiceState extends CreateSalesOrderState {}

class SuccessConfirmInvoiceState extends CreateSalesOrderState {}

class FailureConfirmInvoiceState extends CreateSalesOrderState {}

class LoadingGetInvoiceDetailsState extends CreateSalesOrderState {}

class SuccessGetInvoiceDetailsState extends CreateSalesOrderState {}

class FailureGetInvoiceDetailsState extends CreateSalesOrderState {}

class ChangingWareHouseState extends CreateSalesOrderState {}

class LoadingUpdatePaymentState extends CreateSalesOrderState {}

class SuccessUpdatePaymentState extends CreateSalesOrderState {}

class FailureUpdatePaymentState extends CreateSalesOrderState {}

class AllTasksDoneState extends CreateSalesOrderState {}
