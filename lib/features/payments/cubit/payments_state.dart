part of 'payments_cubit.dart';

@immutable
abstract class PaymentsState {}

class PaymentsInitial extends PaymentsState {}
class ChangingPaymentMethodState extends PaymentsState {}
class ChangingContainerColorState extends PaymentsState {}
class RadioButtonChangingState extends PaymentsState {}
class FailureGetJournalsState extends PaymentsState {}
class SuccessGetJournalsState extends PaymentsState {}
class LoadingGetJournalsState extends PaymentsState {}

class FailureCreatePaymentState extends PaymentsState {}
class SuccessCreatePaymentState extends PaymentsState {}
class LoadingCreatePaymentState extends PaymentsState {}

class FailureConfirmPaymentState extends PaymentsState {}
class SuccessConfirmPaymentState extends PaymentsState {}
class LoadingConfirmPaymentState extends PaymentsState {}

class FailureCreateInvoiceState extends PaymentsState {}
class SuccessCreateInvoiceState extends PaymentsState {}
class LoadingCreateInvoiceState extends PaymentsState {}

class LoadingGetPaymentByIdState extends PaymentsState {}
class SuccessGetPaymentByIdState extends PaymentsState {}
class FailureGetPaymentByIdState extends PaymentsState {}

class FailureInvoiceLinesState extends PaymentsState {}
class SuccessInvoiceLinesState extends PaymentsState {}
class LoadingInvoiceLinesState extends PaymentsState {}
class LoadingUpdatePaymentState extends PaymentsState {}
class FailureUpdatePaymentState extends PaymentsState {}
class SuccessUpdatePaymentState extends PaymentsState {}

