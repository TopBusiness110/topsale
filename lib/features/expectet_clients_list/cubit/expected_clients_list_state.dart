part of 'expected_clients_list_cubit.dart';

@immutable
abstract class ExpectedClientsListState {}

class ExpectedClientsListInitial extends ExpectedClientsListState {}
class NewExpectedClientAdded extends ExpectedClientsListState {}
class FailureGetLeadsState extends ExpectedClientsListState {}
class LoadingGetLeadsState extends ExpectedClientsListState {}
class SuccessGetLeadsState extends ExpectedClientsListState {}
