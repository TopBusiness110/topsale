import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/product_model.dart';

part 'dismissal_notice_state.dart';

class DismissalNoticeCubit extends Cubit<DismissalNoticeState> {
  DismissalNoticeCubit() : super(DismissalNoticeInitial());
  final List<String> items = [
    ' مخزن1',
    'مخزن2',
    'مخزن3',
    'مخزن4',
  ];
  String? selectedFromStockValue;
  String? selectedToStockValue;
  selectFromStock(value){
    selectedFromStockValue = value;
   // changeButtonColor(true);

    //isSelected = true;
    emit(ChangingStockState());
  }

  selectToStock(value){
    selectedToStockValue = value;
    // changeButtonColor(true);

    //isSelected = true;
    emit(ChangingStockState());
  }
  List<ProductModel> selectedProducts = [];

  addProduct({ required ProductModel product}) {

    if(selectedProducts.isEmpty){
      print("____________________selectedProducts.isEmpty __________________________");
      product.userOrderedQuantity++;
      selectedProducts.add(product);
      emit(AddDismissalProductsState());
      return;
    }
    else{
      for(int i = 0 ; i<selectedProducts.length ; i++){
        //  product already exists in list
        if(selectedProducts[i].code==product.code&&selectedProducts[i].quantity! > product.userOrderedQuantity){

          print("+++++++++++++++++++++product already exists in list+++++++++++++++++++++++++++++++++");
          product.userOrderedQuantity++;
          emit(AddDismissalProductsState());
          return ;

        }


        //product already exists in list
        // if(selectedProducts[i].code==product.code&&selectedProducts[i].quantity! > product.userOrderedQuantity){
        //
        //     print("+++++++++++++++++++++product already exists in list+++++++++++++++++++++++++++++++++");
        //     product.userOrderedQuantity++;
        //     //selectedProducts[i].userOrderedQuantity++;
        //     print(selectedProducts);
        //     emit(AddProductsState());
        //     break;
        //
        // }
        // else{
        //   print("***************product doesn't exist in the list************************");
        //   product.userOrderedQuantity++;
        //   selectedProducts.add(product);
        //   print(selectedProducts);
        //   emit(AddProductsState());
        //   break;
        // }
      }

      print("____________________selectedProducts doesn't exist __________________________");
      product.userOrderedQuantity++;
      selectedProducts.add(product);
      emit(AddDismissalProductsState());

    }
  }


  removeProduct({ required ProductModel product}) {
    if ( product.userOrderedQuantity>0) {
      product.userOrderedQuantity = product.userOrderedQuantity - 1;
      emit(RemoveDismissalProductsState());
    }
    else if(product.userOrderedQuantity ==0 ){
      selectedProducts.remove(product);
      emit(RemoveDismissalProductsState());

    }
  }
}
