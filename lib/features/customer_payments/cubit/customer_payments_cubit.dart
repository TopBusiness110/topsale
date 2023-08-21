import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'customer_payments_state.dart';

class CustomerPaymentsCubit extends Cubit<CustomerPaymentsState> {
  CustomerPaymentsCubit() : super(CustomerPaymentsInitial());
  String currentClient = '';
  final List<String> clients = ['Arjun', 'Asha', 'Roland', 'Victoria', 'Golnaz','Alice', "Bob", "Charlie","Zara", "Mahnaz", "Ayan"];
  final List<String> phoneNumbers = ['010209856', '012666543', '011239998', '0129888876', '01005554411','011138876', "012265554", "0222400814","0100777654", "012666543", "0129987655"];
  List<String> matches = [];
  bool isSelected = false;
  final List<String> items = [
    'بائع البنك',
    'شركة البنك الثانية',
    'بائع النقدية',
    'شركة كاش ثانية',
  ];
  String? selectedValue;
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

  searchForName(String target){
    matches.clear();
    for( var name in clients){
      if(name.toLowerCase().startsWith(target.toLowerCase())){
        matches.add(name);
        emit(SearchingResultsState());
      }
    }

  }
  selectClientName(String name){
    currentClient = name;
    emit(SelectingNameState());
  }
}
