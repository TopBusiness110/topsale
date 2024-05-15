import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:topsale/core/models/all_journals_model.dart';
import 'package:topsale/core/models/allusers_model.dart';
import 'package:topsale/core/models/client_model.dart';
import 'package:topsale/core/models/defaul_model.dart';
import 'package:topsale/core/models/get_payment_by_id.dart';
import 'package:topsale/core/models/update_payment_state_model.dart';
import 'package:topsale/core/remote/service_api.dart';
import 'dart:io';
import 'dart:typed_data';

import '../../../core/methods/clients.dart';

part 'customer_payments_state.dart';

class CustomerPaymentsCubit extends Cubit<CustomerPaymentsState> {
  CustomerPaymentsCubit(this.api) : super(CustomerPaymentsInitial());
  ServiceApi api;

  TextEditingController datePickedController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  String currentClient = '';
  //final List<String> clients = ['Arjun', 'Asha', 'Roland', 'Victoria', 'Golnaz','Alice', "Bob", "Charlie","Zara", "Mahnaz", "Ayan"];
  // final List<String> phoneNumbers = ['010209856', '012666543', '011239998', '0129888876', '01005554411','011138876', "012265554", "0222400814","0100777654", "012666543", "0129987655"];
  List<UsersList> matches = [];
  bool isSelected = false;
  final List<String> items = [
    'شركة البنك الثانية',
    'بائع النقدية',
    'شركة كاش ثانية',
  ];
  String? selectedValue;
  selectPaymentMethod(value) {
    selectedValue = value;
    changeButtonColor(true);

    //isSelected = true;
    emit(ChangingPaymentMethodState());
  }

  changeButtonColor(bool isSelected) {
    this.isSelected = isSelected;
    print(isSelected);
    emit(ChangingContainerColorState());
  }

  AllUsersModel? allUsersModel;
  getAllUsers({
    int pageId = 1,
    bool isGetMore = false,
  }) async {
    isGetMore
        ? emit(Loading2GetAllUsersState())
        : emit(LoadingGetAllUsersState());
    matches.clear();

    final response = await api.getAllUsers(pageId, 1000);
    response.fold((l) {
      emit(FailureGetAllUsersState());
    }, (r) {
      if (isGetMore) {
        allUsersModel = AllUsersModel(
          count: r.count,
          next: r.next,
          prev: r.prev,
          result: [...allUsersModel!.result!, ...r.result!],
        );
      } else {
        allUsersModel = r;
      }

      matches.addAll(allUsersModel!.result!);
      emit(SuccessGetAllUsersState());
    });
  }

  searchForName(String target) {
    matches.clear();
    for (int i = 0; i < allUsersModel!.result!.length; i++) {
      if (allUsersModel!.result![i].name!.toLowerCase().contains(target)) {
        matches.add(allUsersModel!.result![i]);
        emit(SearchingResultsState());
      }
    }
  }

  selectClientName(String name) {
    currentClient = name;
    emit(SelectingNameState());
  }

  // clearFields(){
  //   datePickedController.text="";
  //   amountController.text="";
  //   memoController.text="";
  //   selectedPaymentValue="";
  //   currentClient="";
  //   emit(AllFieldsCleared());
  //
  // }

  GetAllJournalsModel? allJournalsModel;
  getAllJournals() async {
    emit(LoadingGetJournalsState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getAllJournals();
    response.fold((l) => emit(FailureGetJournalsState()), (r) {
      emit(SuccessGetJournalsState());
      allJournalsModel = r;

      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }

  DefaultModel? createPaymentMethodModel;
  createPaymentMethod({
    required int partnerId,
  }) async {
    emit(LoadingCreatePaymentMethodState());

    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.createPaymentMethod(
        partnerId: partnerId,
        journalId: int.parse(selectedValue!),
        amount: amountController.text,
        ref: memoController.text,
        date: datePickedController.text);
    response.fold((l) => emit(FailureCreatePaymentMethodState()), (r) {
      emit(SuccessCreatePaymentMethodState());
      createPaymentMethodModel = r;
      getMovieId();
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }

  GetPaymentByIdModel? getPaymentByIdModel;
  getPaymentById() async {
    emit(LoadingGetPaymentByIdState());
    // authModel = await Preferences.instance.getUserModel2();
    final response =
        await api.getPaymentById(paymentId: createPaymentMethodModel!.result!);
    response.fold((l) => emit(FailureGetPaymentByIdState()), (r) {
      emit(SuccessGetPaymentByIdState());
      getPaymentByIdModel = r;

      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }

  GetPaymentByIdModel? getMoveIdModel;
  getMovieId() async {
    emit(LoadingGetPaymentByIdState());
    final response =
        await api.getPaymentById(paymentId: createPaymentMethodModel!.result!);
    response.fold((l) => emit(FailureGetPaymentByIdState()), (r) {
      emit(SuccessGetPaymentByIdState());
      getMoveIdModel = r;
      updatePaymentStates();
    });
  }

  UpdatePaymentStateModel? updatePaymentStateModel;
  updatePaymentStates() async {
    emit(LoadingUpdatePaymentState());

    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.updatePaymentState(
        paymentId: getMoveIdModel!.result![0].moveId!);
    response.fold((l) => emit(FailureUpdatePaymentState()), (r) {
      emit(SuccessUpdatePaymentState());
      updatePaymentStateModel = r;
      getPaymentById();
      // r.result!.map((e) => print(e.image1920));
    });
  }

  ScreenshotController screenshotController = ScreenshotController();

  captureScreenshot() async {
    Uint8List? imageInUnit8List =
        await screenshotController.capture(); // store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List!.toList(growable: true));

    Share.shareFiles(
      [file.path],
      text: "share receipt ",
    );
    emit(ScreenshootState());
  }
}
