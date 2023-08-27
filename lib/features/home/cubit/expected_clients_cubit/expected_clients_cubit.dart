import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/expected_client_model.dart';

part 'expected_clients_state.dart';

class ExpectedClientsCubit extends Cubit<ExpectedClientsState> {
  ExpectedClientsCubit() : super(ExpectedClientsInitial());

  List<ExpectedClientModel> expectedClients = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController opportunityController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  addExpectedClient(){
    expectedClients.add(ExpectedClientModel(
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
        opportunity: opportunityController.text,
        email: emailController.text));
    emit(NewClientAdded());

  }
//work correctly
  clearFields(){
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    opportunityController.clear();
    emailController.clear();
    emit(FieldsCleared());
  }



}
