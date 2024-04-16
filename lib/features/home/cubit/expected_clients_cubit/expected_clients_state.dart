part of 'expected_clients_cubit.dart';

@immutable
abstract class ExpectedClientsState {}

class ExpectedClientsInitial extends ExpectedClientsState {}
class NewClientAdded extends ExpectedClientsState {}
class FieldsCleared extends ExpectedClientsState {}
class FailureCreatePartnerState extends ExpectedClientsState {}
class LoadingCreatePartnerState extends ExpectedClientsState {}
class SuccessCreatePartnerState extends ExpectedClientsState {}

class FailureCreateLeadState extends ExpectedClientsState {}
class LoadingCreateLeadState extends ExpectedClientsState {}
class SuccessCreateLeadState extends ExpectedClientsState {}

