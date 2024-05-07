part of 'customer_payments_cubit.dart';

@immutable
abstract class CustomerPaymentsState {}

class CustomerPaymentsInitial extends CustomerPaymentsState {}
class SearchingResultsState extends CustomerPaymentsState {}
class SelectingNameState extends CustomerPaymentsState {}
class ChangingPaymentMethodState extends CustomerPaymentsState {}
class ChangingContainerColorState extends CustomerPaymentsState {}
class AllFieldsCleared extends CustomerPaymentsState {}
class FailureGetJournalsState extends CustomerPaymentsState {}
class SuccessGetJournalsState extends CustomerPaymentsState {}
class LoadingGetJournalsState extends CustomerPaymentsState {}
class LoadingGetAllUsersState extends CustomerPaymentsState {}
class Loading2GetAllUsersState extends CustomerPaymentsState {}
class SuccessGetAllUsersState extends CustomerPaymentsState {}
class FailureGetAllUsersState extends CustomerPaymentsState {}

class LoadingCreatePaymentMethodState extends CustomerPaymentsState {}
class SuccessCreatePaymentMethodState extends CustomerPaymentsState {}
class FailureCreatePaymentMethodState extends CustomerPaymentsState {}

class LoadingGetPaymentByIdState extends CustomerPaymentsState {}
class SuccessGetPaymentByIdState extends CustomerPaymentsState {}
class FailureGetPaymentByIdState extends CustomerPaymentsState {}

class LoadingUpdatePaymentState extends CustomerPaymentsState {}
class SuccessUpdatePaymentState extends CustomerPaymentsState {}
class FailureUpdatePaymentState extends CustomerPaymentsState {}

