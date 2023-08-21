part of 'payments_cubit.dart';

@immutable
abstract class PaymentsState {}

class PaymentsInitial extends PaymentsState {}
class ChangingPaymentMethodState extends PaymentsState {}
class ChangingContainerColorState extends PaymentsState {}
class RadioButtonChangingState extends PaymentsState {}
