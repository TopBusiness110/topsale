import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/models/all_journals_model.dart';
import 'package:topsale/core/models/defaul_model.dart';
import 'package:topsale/core/remote/service_api.dart';

part 'payments_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(this.api) : super(PaymentsInitial());
  ServiceApi api;
  TextEditingController amountController = TextEditingController();
  bool isSelected = false;
  final List<String> items = [
    'بائع البنك',
    'بائع النقدية',
    'شركة كاش ثانية',
  ];
  String? selectedValue;
  int selectedRadioValue = 1;

  setSelectedRadioValue(int value) {
    // setState(() {
    selectedRadioValue = value;
    emit(RadioButtonChangingState());
    // });
  }

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

  int journalId = 0;
  
  selectJournalId( int value) {
    journalId = value;
   

    emit(ChangingPaymentMethodState());
  }
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

  DefaultModel? createPaymentModel;
  createPayment(BuildContext context,
      {required partnerId, required amount}) async {
    emit(LoadingCreatePaymentState());
    final response = await api.createPayment(
        partnerId: partnerId, amount: amount, journalId:int.parse(selectedValue!) );
    response.fold((l) {
      emit(FailureCreatePaymentState());
    }, (r) async {
      if (r.result != null) {
        createPaymentModel = r;


        
        Navigator.pushReplacementNamed(context, Routes.receiptRoute);
        emit(SuccessCreatePaymentState());
      } else {
        emit(FailureCreatePaymentState());
      }
    });
  }

  DefaultModel? createInvoiceModel;
  createInvoice(BuildContext context,
      {required partnerId,
      required productId,
      required quantity,
      required amount}) async {
    emit(LoadingCreateInvoiceState());
    final response = await api.createInvoice(
      partnerId: partnerId,
    );
    response.fold((l) {
      emit(FailureCreateInvoiceState());
    }, (r) async {
      if (r.result != null) {
        createInvoiceModel = r;
        invoiceLine(context,
            productId: productId,
            quantity: quantity,
            partnerId: partnerId,
            amount: amount);
        emit(SuccessCreateInvoiceState());
      } else {
        emit(FailureCreateInvoiceState());
      }
    });
  }

  DefaultModel? invoiceModel;
  invoiceLine(BuildContext context,
      {required productId,
      required quantity,
      required partnerId,
      required amount}) async {
    emit(LoadingInvoiceLinesState());
    final response = await api.invoiceLine(
      moveId: createInvoiceModel!.result!,
      productId: productId,
      quantity: quantity,
    );
    response.fold((l) {
      emit(FailureInvoiceLinesState());
    }, (r) async {
      if (r.result != null) {
        invoiceModel = r;
        if (selectedRadioValue == 2) {
          createPayment(context, partnerId: partnerId, amount: amount);
        } else {
          Navigator.pushReplacementNamed(context, Routes.receiptRoute);
          emit(SuccessInvoiceLinesState());
        }
      } else {
        emit(FailureInvoiceLinesState());
      }
    });
  }
}
