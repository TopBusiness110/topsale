import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/defaul_model.dart';
import 'package:topsale/core/models/expected_client_model.dart';
import 'package:topsale/core/remote/service_api.dart';

part 'expected_clients_state.dart';

class ExpectedClientsCubit extends Cubit<ExpectedClientsState> {
  ExpectedClientsCubit(this.api) : super(ExpectedClientsInitial());
  ServiceApi api;

  List<ExpectedClientModel> expectedClients = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController opportunityController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  addExpectedClient() {
    expectedClients.add(ExpectedClientModel(
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
        opportunity: opportunityController.text,
        email: emailController.text));
    emit(NewClientAdded());
  }

//work correctly
  clearFields() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    opportunityController.clear();
    emailController.clear();
    emit(FieldsCleared());
  }

  DefaultModel? createPartnerModel;
  createPartner() async {
    emit(LoadingCreatePartnerState());
  
    final response = await api.createPartner(
      name: nameController.text,
      mobile: phoneController.text,
      street: addressController.text,
    );
    response.fold((l) => emit(FailureCreatePartnerState()), (r) {
      emit(SuccessCreatePartnerState());
      createPartnerModel = r;
      createLead();
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }

  DefaultModel? createLeadModel;
  createLead() async {
    emit(LoadingCreateLeadState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.addNewLead(
        partnerId: createPartnerModel!.result!,
        name: nameController.text,
        mobile: phoneController.text,
        street: addressController.text,
        description: opportunityController.text);
    response.fold((l) => emit(FailureCreateLeadState()), (r) {
      emit(SuccessCreateLeadState());
      createLeadModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }
}
