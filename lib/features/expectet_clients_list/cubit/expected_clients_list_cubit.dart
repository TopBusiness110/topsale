import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/expected_client_model.dart';

part 'expected_clients_list_state.dart';

class ExpectedClientsListCubit extends Cubit<ExpectedClientsListState> {
  ExpectedClientsListCubit() : super(ExpectedClientsListInitial()){

  }

  List<ExpectedClientModel?>? expectedClients = [];

  fillExpectedClientsList(
      {
   required String name,
  required  String phone,
    String? address,
  required  String opportunity,
    String? email,
  }){
    expectedClients?.add(ExpectedClientModel(
        name: name,
        phone: phone,
        address: address,
        opportunity: opportunity,
        email: email));
    emit(NewExpectedClientAdded());
  }
}
