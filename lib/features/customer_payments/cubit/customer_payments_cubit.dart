import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/client_model.dart';

import '../../../core/methods/clients.dart';

part 'customer_payments_state.dart';

class CustomerPaymentsCubit extends Cubit<CustomerPaymentsState> {
  CustomerPaymentsCubit() : super(CustomerPaymentsInitial());

  TextEditingController datePickedController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  String currentClient = '';
  //final List<String> clients = ['Arjun', 'Asha', 'Roland', 'Victoria', 'Golnaz','Alice', "Bob", "Charlie","Zara", "Mahnaz", "Ayan"];
 // final List<String> phoneNumbers = ['010209856', '012666543', '011239998', '0129888876', '01005554411','011138876', "012265554", "0222400814","0100777654", "012666543", "0129987655"];
  List<ClientModel> matches = [];
  bool isSelected = false;
  final List<String> items = [
    'بائع البنك',
    'شركة البنك الثانية',
    'بائع النقدية',
    'شركة كاش ثانية',
  ];
  String? selectedPaymentValue;
  selectPaymentMethod(value){
    selectedPaymentValue = value;
    changeButtonColor(true);

    //isSelected = true;
    emit(ChangingPaymentMethodState());
  }
  changeButtonColor(bool isSelected){
    this.isSelected = isSelected;
    print(isSelected);
    emit(ChangingContainerColorState());
  }

  searchForName(String target){
    matches.clear();
    for( var client in clients){
      if(client.name.toLowerCase().startsWith(target.toLowerCase())){
        matches.add(client);
        emit(SearchingResultsState());
      }
    }

  }
  selectClientName(String name){
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
}
