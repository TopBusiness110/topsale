import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/product_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  List<ProductModel> matches = [];
  List<ProductModel> selectedProducts = [];

  addProduct({ required ProductModel product}) {
    if(selectedProducts.isEmpty){
      print("____________________selectedProducts.isEmpty __________________________");
      product.userOrderedQuantity++;
      selectedProducts.add(product);
      emit(AddProductsState());
      return;
    }
    else{
      for(int i = 0 ; i<selectedProducts.length ; i++){
      //  product already exists in list

        if(selectedProducts[i].code==product.code&&selectedProducts[i].quantity! > product.userOrderedQuantity){
            print("+++++++++++++++++++++product already exists in list+++++++++++++++++++++++++++++++++");
            product.userOrderedQuantity++;
            emit(AddProductsState());
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
      emit(AddProductsState());

    }
  }


  removeProduct({ required ProductModel product}) {
    if ( product.userOrderedQuantity>0) {
      product.userOrderedQuantity = product.userOrderedQuantity - 1;
      emit(RemoveProductsState());
    }
    else if(product.userOrderedQuantity ==0 ){
      selectedProducts.remove(product);
      emit(RemoveProductsState());

    }
  }

  searchInProducts(String key , List<ProductModel> products){
    matches.clear();
    for(int i = 0 ; i<products.length ; i++){

      if(products[i].name!.toLowerCase().contains(key)){
        matches.add(products[i]);
        emit(SearchingState());
      }
    }

  }
}
