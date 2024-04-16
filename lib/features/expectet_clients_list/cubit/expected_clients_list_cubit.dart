import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/all_leads_model.dart';
import 'package:topsale/core/remote/service_api.dart';

import '../../../core/models/expected_client_model.dart';

part 'expected_clients_list_state.dart';

class ExpectedClientsListCubit extends Cubit<ExpectedClientsListState> {
  ExpectedClientsListCubit(this.api) : super(ExpectedClientsListInitial()) {}
  ServiceApi api;
  List<ExpectedClientModel?>? expectedClients = [];

  fillExpectedClientsList({
    required String name,
    required String phone,
    String? address,
    required String opportunity,
    String? email,
  }) {
    expectedClients?.add(ExpectedClientModel(
        name: name,
        phone: phone,
        address: address,
        opportunity: opportunity,
        email: email));
    emit(NewExpectedClientAdded());
  }

  GetAllLeadsModel? allLeadsModel;
  getAllLeads() async {
    emit(LoadingGetLeadsState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getAllLeads();
    response.fold((l) => emit(FailureGetLeadsState()), (r) {
      emit(SuccessGetLeadsState());
      allLeadsModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }
}
