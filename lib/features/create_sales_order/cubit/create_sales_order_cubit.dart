import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/core/models/all_journals_model.dart';
import 'package:topsale/core/models/all_prodyucts_model.dart';
import 'package:topsale/core/models/allusers_model.dart';
import 'package:topsale/core/models/defaul_model.dart';
import 'package:topsale/core/models/product_model.dart';
import 'package:topsale/core/remote/service_api.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';

import '../../../core/models/selected_products.dart';

part 'create_sales_order_state.dart';

class CreateSalesOrderCubit extends Cubit<CreateSalesOrderState> {
  CreateSalesOrderCubit(this.api) : super(CreateSalesOrderInitial());
  ServiceApi api;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  DateTime dateTime = DateTime.now();
  String billingStatus = "مؤكد";
  String billingNumber = "Xz012345";

  String currentClient = '';
  int currentClientId = 0;
  List<UsersList> matches = [];

  double sum = 0;
/////////////////////////

  DefaultModel? createOrderModel;

  createSaleOrder(
    BuildContext context,
  ) async {
    emit(LoadingCreateSaleOrderState());

    final response = await api.createSaleOrder(currentClientId);
    response.fold((l) {
      print('gggggggg');

      emit(FailureCreateSaleOrderState());
    }, (r) async {
      print('gggggggggggggggg');
      if (r.result != null) {
        createOrderModel = r;
        emit(SuccessCreateSaleOrderState());
      } else {}
    });
  }

  DefaultModel? createOrderLineModel;
  createSaleOrderLine(BuildContext context,
      {required int productId, required int productQuantity}) async {
    emit(LoadingCreateSaleOrderLineState());
    final response = await api.createSaleOrderLines(
        orderId: createOrderModel!.result!,
        productId: productId,
        productQuantity: productQuantity);
    response.fold((l) {
      print('gggggggg');

      emit(FailureCreateSaleOrderLineState());
    }, (r) async {
      print('gggggggggggggggg');
      if (r.result != null) {
        createOrderLineModel = r;
        emit(SuccessCreateSaleOrderLineState());
      } else {}
    });
  }

//********** client *******************************
  selectClientName(String name, int id) {
    currentClient = name;
    currentClientId = id;
    print('ddddddddddd $currentClientId');
    emit(SelectingNameState());
  }

  AllUsersModel? allUsersModel;
  getAllUsers() async {
    matches.clear();
    emit(LoadingGetAllUsersState());
    final response = await api.getAllUsers();
    response.fold((l) {
      emit(FailureGetAllUsersState());
    }, (r) {
      allUsersModel = r;
      matches.addAll(r.result!);
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

  addNewClient() {
    // clients.add(ClientModel(
    //     name: nameController.text,
    //     phoneNumber: phoneController.text,
    //     address: addressController.text));
    // nameController.clear();
    // phoneController.clear();
    // addressController.clear();
    emit(AddingNewClient());
  }

  //************** product ******************

  addProduct(
      {required ProductModelData product, required BuildContext context}) {
    if (product.qty_available! > product.userOrderedQuantity) {
      //product.userOrderedQuantity = product.userOrderedQuantity + 1;
      context.read<ProductsCubit>().addProduct(product: product);

      emit(AddProductState());
    }
  }

  removeProduct(
      {required ProductModelData product,
      List<ProductModelData>? products,
      required BuildContext context}) {
    if (product.userOrderedQuantity > 1) {
      // product.userOrderedQuantity = product.userOrderedQuantity - 1;
      context.read<ProductsCubit>().removeProduct(product: product);
      emit(RemoveProductState());
    } else if (product.userOrderedQuantity == 1) {
      products?.remove(product);
      emit(DeleteProductState());
    }
  }

  //************** price *****************

  calculateTotalPrice(SelectedProducts selectedProducts) {
    sum = 0;
    if (selectedProducts.products.isNotEmpty) {
      for (int i = 0; i < selectedProducts.products.length; i++) {
        sum += (selectedProducts.products[i].userOrderedQuantity *
            selectedProducts.products[i].listPrice!);
      }
      emit(CalculatingTotalPrice());
    }
  }
}
