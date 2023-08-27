part of 'expected_clients_cubit.dart';

@immutable
abstract class ExpectedClientsState {}

class ExpectedClientsInitial extends ExpectedClientsState {}
class NewClientAdded extends ExpectedClientsState {}
class FieldsCleared extends ExpectedClientsState {}
