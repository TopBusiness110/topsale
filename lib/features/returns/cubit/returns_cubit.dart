import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/models/all_prodyucts_model.dart';
import 'package:topsale/core/models/client_model.dart';
import 'package:topsale/core/models/defaul_model.dart';
import 'package:topsale/core/models/get_order_details_model.dart';
import 'package:topsale/core/models/get_partner_orders_model.dart';
import 'package:topsale/core/remote/service_api.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';

import '../../../core/methods/clients.dart';
import '../../../core/models/product_model.dart';
import '../../cart/cart_model.dart';

part 'returns_state.dart';

class ReturnsCubit extends Cubit<ReturnsState> {
  ReturnsCubit(this.api) : super(ReturnsInitial());
  ServiceApi api;

  List<ProductModelData> listOfProducts = [];

  String currentClient = '';
  List<ClientModel> matches = [];

  List<String> selectedProducts = [];

  addProducts(String product) {
    selectedProducts.add(product);
    emit(AddingProductState());
  }

  searchForName(String target) {
    matches.clear();
    for (var client in clients) {
      if (client.name.toLowerCase().startsWith(target.toLowerCase())) {
        matches.add(client);
        emit(SearchingResultsState());
      }
    }
  }

  selectClientName(String name) {
    currentClient = name;
    emit(SelectingNameState());
  }

  List<ProductModelData>? searchForProductsForClient(
      String clientName, List<CartModel> cart) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].clientName.toLowerCase() == clientName.toLowerCase()) {
        emit(ClientCartFounded());
        listOfProducts = cart[i].listOfProducts;
        return cart[i].listOfProducts;
      }
    }
    return null;
  }

  addProductQuantity(int index) {
    int quantity = listOfProducts[index].qty_available!;
    int userOrderedQuantity = listOfProducts[index].userOrderedQuantity;
    if (userOrderedQuantity <= quantity) {
      listOfProducts[index].userOrderedQuantity++;
      emit(AddedState());
    }
  }

  decreaseProductQuantity(int index) {
    int quantity = listOfProducts[index].qty_available!;
    int userOrderedQuantity = listOfProducts[index].userOrderedQuantity;
    if (userOrderedQuantity == 0) {
      removeProduct(index);
      return;
    } else if (userOrderedQuantity <= quantity) {
      listOfProducts[index].userOrderedQuantity--;
      emit(RemoveState());
    }
  }

  removeProduct(index) {
    listOfProducts.removeAt(index);
    emit(ProductRemoved());
  }

  GetSaleOrderForPartnerModel? getPartnerOrdersModel;
  getPartnerOrders(int partnerId) async {
    emit(LoadingGetPartnerOrdersState());
    final response = await api.getAllSaleOrderForMan(partnerId);
    response.fold((l) => emit(FailureGetPartnerOrdersState()), (r) {
      emit(SuccessGetPartnerOrdersState());
      getPartnerOrdersModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }

  GetManOrderDetailsModel? getManOrderDetailsModel;
  getPartnerOrderDetails(int orderId) async {
    emit(LoadingGetPartnerOrdersDetailsState());
    final response = await api.getAllSaleOrderForManDetails(orderId);
    response.fold((l) => emit(FailureGetPartnerOrdersDetailsState()), (r) {
      emit(SuccessGetPartnerOrdersDetailsState());
      getManOrderDetailsModel = r;
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }

  DefaultModel? createOrderModel;

  createSaleOrder(
    BuildContext context,
  ) async {
    emit(LoadingCreateSaleOrderState());

    final response = await api
        .createSaleOrder(context.read<CreateSalesOrderCubit>().currentClientId);
    response.fold((l) {
      print('gggggggg');
      emit(FailureCreateSaleOrderState());
    }, (r) async {
      if (r.result != null) {
        createOrderModel = r;

        for (int i = 0; i < getManOrderDetailsModel!.result!.length; i++) {
          await createSaleOrderLine(context,
              productId: getManOrderDetailsModel!.result![i].productId!,
              productQuantity:
                  -getManOrderDetailsModel!.result![i].userProductUomQty,
              orderId: r.result!);
        }
      } else {}
    });

    emit(SuccessCreateSaleOrderState());
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.homeRoute, (route) => false);
  }

  DefaultModel? createOrderLineModel;
  createSaleOrderLine(BuildContext context,
      {required int orderId,
      required int productId,
      required productQuantity}) async {
    emit(LoadingCreateSaleOrderLineState());
    final response = await api.createSaleOrderLines(
        orderId: orderId,
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
}
