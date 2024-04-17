import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/all_prodyucts_model.dart';
import 'package:topsale/core/models/client_model.dart';

import '../../../core/methods/clients.dart';
import '../../../core/models/product_model.dart';
import '../../cart/cart_model.dart';

part 'returns_state.dart';

class ReturnsCubit extends Cubit<ReturnsState> {
  ReturnsCubit() : super(ReturnsInitial());


  List<ProductModelData> listOfProducts= [];

  String currentClient = '';
  List<ClientModel> matches = [];

  List<String> selectedProducts = [];

  addProducts(String product){
    selectedProducts.add(product);
    emit(AddingProductState());
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

 List<ProductModelData>? searchForProductsForClient(String clientName ,List<CartModel> cart){
    for(int i = 0 ; i<cart.length ; i++){
      if(cart[i].clientName.toLowerCase()==clientName.toLowerCase()){
        emit(ClientCartFounded());
        listOfProducts = cart[i].listOfProducts;
        return cart[i].listOfProducts;
      }
    }
    return null;
  }

addProductQuantity(int index){
    int quantity = listOfProducts[index].qty_available!;
    int userOrderedQuantity = listOfProducts[index].userOrderedQuantity;
    if(userOrderedQuantity<=quantity) {
      listOfProducts[index].userOrderedQuantity++;
      emit(AddedState());
    }
}
  decreaseProductQuantity(int index){
    int quantity = listOfProducts[index].qty_available!;
    int userOrderedQuantity = listOfProducts[index].userOrderedQuantity;
    if(userOrderedQuantity==0){
      removeProduct(index);
      return ;

    }
   else if(userOrderedQuantity<=quantity) {
      listOfProducts[index].userOrderedQuantity--;
     emit(RemoveState());
    }

  }

removeProduct(index){
    listOfProducts.removeAt(index);
    emit(ProductRemoved());
}
}
