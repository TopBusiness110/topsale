import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/client_model.dart';
import 'package:topsale/core/models/product_model.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';

import '../../../core/methods/clients.dart';
import '../../../core/models/selected_products.dart';

part 'create_sales_order_state.dart';

class CreateSalesOrderCubit extends Cubit<CreateSalesOrderState> {
  CreateSalesOrderCubit() : super(CreateSalesOrderInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  DateTime dateTime = DateTime.now();
  String billingStatus = "مؤكد";
  String billingNumber = "Xz012345";


  String currentClient = '';
  List<ClientModel> matches = [];
  double sum = 0 ;

//********** client *******************************
  selectClientName(String name){
    currentClient = name;
    emit(SelectingNameState());
  }
  searchForName(String target){
    matches.clear();
    for( var client in clients){
      if(client.name.toLowerCase().startsWith(target.toLowerCase())){
        matches.add(client);
        emit(SearchingResultsState());
      }
    }
   if(matches.isEmpty){
     emit(NoClientsMatchesState());
   }
  }
  addNewClient(){
    clients.add(ClientModel(name: nameController.text,
        phoneNumber: phoneController.text,address:addressController.text ));
     // nameController.clear();
     // phoneController.clear();
     // addressController.clear();
    emit(AddingNewClient());
  }
  
  //************** product ******************

  addProduct({ required ProductModel product, required BuildContext context}) {

    if (product.quantity! > product.userOrderedQuantity) {
     // product.userOrderedQuantity = product.userOrderedQuantity + 1;
      context.read<ProductsCubit>().addProduct(product: product);

      emit(AddProductState());
    }
  }

  removeProduct({ required ProductModel product,  List<ProductModel>? products , required BuildContext context}) {
    if ( product.userOrderedQuantity>0) {
     // product.userOrderedQuantity = product.userOrderedQuantity - 1;
      context.read<ProductsCubit>().removeProduct(product: product);
      emit(RemoveProductState());
    }
    else if(product.userOrderedQuantity ==0 ){
      products?.remove(product);
      emit(DeleteProductState());


    }
  }

  //************** price *****************

    calculateTotalPrice(SelectedProducts selectedProducts){
    sum = 0 ;
    if(selectedProducts.products.isNotEmpty){

      for(int i = 0 ; i<selectedProducts.products.length ; i++){
        sum+=(selectedProducts.products[i].userOrderedQuantity*selectedProducts.products[i].price!);

    }
      emit(CalculatingTotalPrice());


    }

      }
}
