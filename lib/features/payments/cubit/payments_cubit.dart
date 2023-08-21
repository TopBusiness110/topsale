import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'payments_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit() : super(PaymentsInitial());
  TextEditingController amountController = TextEditingController();
  bool isSelected = false;
  final List<String> items = [
    'بائع البنك',
    'شركة البنك الثانية',
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




  selectPaymentMethod(value){
    selectedValue = value;
    changeButtonColor(true);

    //isSelected = true;
    emit(ChangingPaymentMethodState());
  }

  changeButtonColor(bool isSelected){
    this.isSelected = isSelected;
    print(isSelected);
    emit(ChangingContainerColorState());
  }
}
