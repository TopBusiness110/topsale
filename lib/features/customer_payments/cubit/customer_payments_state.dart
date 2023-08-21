part of 'customer_payments_cubit.dart';

@immutable
abstract class CustomerPaymentsState {}

class CustomerPaymentsInitial extends CustomerPaymentsState {}
class SearchingResultsState extends CustomerPaymentsState {}
class SelectingNameState extends CustomerPaymentsState {}
class ChangingPaymentMethodState extends CustomerPaymentsState {}
class ChangingContainerColorState extends CustomerPaymentsState {}
