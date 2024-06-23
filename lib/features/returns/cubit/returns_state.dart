part of 'returns_cubit.dart';

@immutable
abstract class ReturnsState {}

class ReturnsInitial extends ReturnsState {}

class SearchingResultsState extends ReturnsState {}

class SelectingNameState extends ReturnsState {}

class AddingProductState extends ReturnsState {}

class ClientCartFounded extends ReturnsState {}

class AddedState extends ReturnsState {}

class ProductRemoved extends ReturnsState {}

class RemoveState extends ReturnsState {}

class LoadingGetPartnerOrdersState extends ReturnsState {}

class SuccessGetPartnerOrdersState extends ReturnsState {}

class FailureGetPartnerOrdersState extends ReturnsState {}

class LoadingGetPartnerOrdersDetailsState extends ReturnsState {}

class SuccessGetPartnerOrdersDetailsState extends ReturnsState {}

class FailureGetPartnerOrdersDetailsState extends ReturnsState {}

class LoadingCreateSaleOrderState extends ReturnsState {}

class SuccessCreateSaleOrderState extends ReturnsState {}

class FailureCreateSaleOrderState extends ReturnsState {}

class LoadingCreateSaleOrderLineState extends ReturnsState {}

class SuccessCreateSaleOrderLineState extends ReturnsState {}

class FailureCreateSaleOrderLineState extends ReturnsState {}

class LoadingOrderRelationState extends ReturnsState {}

class SuccessOrderRelationState extends ReturnsState {}

class FailureOrderRelationState extends ReturnsState {}

class LoadingConfirmInvoiceState extends ReturnsState {}

class SuccessConfirmInvoiceState extends ReturnsState {}

class FailureConfirmInvoiceState extends ReturnsState {}

class LoadingGetInvoiceDetailsState extends ReturnsState {}

class SuccessGetInvoiceDetailsState extends ReturnsState {}

class FailureGetInvoiceDetailsState extends ReturnsState {}

class CalculatingTotalPriceState extends ReturnsState {}
class FailureGetTaxesState extends ReturnsState {}
class SuccessGetTaxesState extends ReturnsState {}
class LoadingGetTaxesState extends ReturnsState {}
class LoadingUpdatePaymentState extends ReturnsState {}
class FailureUpdatePaymentState extends ReturnsState {}
class SuccessUpdatePaymentState extends ReturnsState {}

