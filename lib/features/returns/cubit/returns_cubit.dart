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
import 'package:topsale/core/models/get_taxes_model.dart';
import 'package:topsale/core/models/invoice_details_model.dart';
import 'package:topsale/core/models/selected_products.dart';
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
  int selectedPartnerId = 0;
  List<String> selectedProducts = [];
  double sum = 0;
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

  calculateTotalPrice() {
    sum = 0;
    if (getManOrderDetailsModel != null) {
      getManOrderDetailsModel!.result!.forEach((element) {
        sum += element.priceSubtotal;
      });
    }
    emit(CalculatingTotalPriceState());
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
      calculateTotalPrice();
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
    });
  }

  // DefaultModel? createOrderModel;

  createSaleOrder(BuildContext context, int orderId) async {
    emit(LoadingCreateSaleOrderState());

    // final response = await api
    //     .createSaleOrder(context.read<CreateSalesOrderCubit>().currentClientId);
    // response.fold((l) {
    //   print('gggggggg');
    //   emit(FailureCreateSaleOrderState());
    // }, (r) async {
    //   if (r.result != null) {
    //   createOrderModel = r;

    for (int i = 0; i < getManOrderDetailsModel!.result!.length; i++) {
      await createSaleOrderLine(context,
          productId: getManOrderDetailsModel!.result![i].productId!,
          productQuantity:
              -getManOrderDetailsModel!.result![i].userProductUomQty,
          orderId: orderId);
    }
    orderRelation(context, orderId);
    // } else {}
    // });

    emit(SuccessCreateSaleOrderState());
    
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
  String? getAccountMoveNumber(String result) {
    RegExp regExp = RegExp(r'\((\d+),\)');
    Match? match = regExp.firstMatch(result);

    if (match != null) {
      String extractedNumber = match.group(1)!;
      print('Extracted number: $extractedNumber');
      return extractedNumber;
    } else {
      print('No match found');
      return null;
    }
  }

  DefaultModel? orderRelationModel;
  orderRelation(BuildContext context, int orderId) async {
    emit(LoadingOrderRelationState());
    // if (createOrderModel != null) {
    final response = await api.orderRelation(
      orderId: orderId,
    );
    response.fold((l) {
      emit(FailureOrderRelationState());
    }, (r) async {
      if (r.result != null) {
        orderRelationModel = r;
        if (getAccountMoveNumber(r.result.toString()) != null) {
          confirmInvoice(
            context,
            partnerId: context.read<CreateSalesOrderCubit>().currentClientId,
            accountMoveNumber: getAccountMoveNumber(r.result.toString()),
          );
        }
        emit(SuccessOrderRelationState());
      } else {}
    });
    // } else {
    //   print("nullll");
    // }
  }

  DefaultModel? confirmInvoiceModel;
  confirmInvoice(BuildContext context,
      {required accountMoveNumber, required partnerId}) async {
    emit(LoadingConfirmInvoiceState());
    // if (createOrderModel != null) {
    final response = await api.confirmInvoice(
      partnerId: partnerId,
      accountMoveNumber: accountMoveNumber,
    );
    response.fold((l) {
      emit(FailureConfirmInvoiceState());
    }, (r) async {
      print('gggggggggggggggg');
      if (r.result != null) {
        confirmInvoiceModel = r;
        if (orderRelationModel != null)
          getInvoiceDetails(
              accountMoveNumber:
                  getAccountMoveNumber(orderRelationModel!.result.toString()));
        //  Navigator.pushReplacementNamed(context, Routes.homeRoute);
        Navigator.pushReplacementNamed(context, Routes.receiptReturnsRoute);
        emit(SuccessConfirmInvoiceState());
      } else {}
    });
    // } else {
    //   print("nullll");
    // }
  }
  InvoiceDetailsModel? invoiceDetailsModel;
  getInvoiceDetails({required dynamic accountMoveNumber}) async {
    emit(LoadingGetInvoiceDetailsState());
    // if (createOrderModel != null) {
    final response = await api.getInvoiceDetails(
      accountMoveNumber: accountMoveNumber,
    );
    response.fold((l) {
      emit(FailureGetInvoiceDetailsState());
    }, (r) async {
      if (r.name != null) {
        invoiceDetailsModel = r;

        emit(SuccessGetInvoiceDetailsState());
      } else {}
    });
    // } else {
    // print("nullll");
    // }
  }

  GetTaxesModel? getTaxesModel;
  double taxesSum = 0;
  List<double> taxes = [];
  getTaxes() async {
    emit(LoadingGetTaxesState());
    taxes = [];
    taxesSum = 0;
    getManOrderDetailsModel!.result!.forEach((element) async {
      if (element.taxesId!.isNotEmpty) {
        final response = await api.getTaxes(element.taxesId![0]);
        response.fold((l) => emit(FailureGetTaxesState()), (r) {
          taxes
              .add(double.parse(r.result![0].displayName!.replaceAll("%", "")));
          taxesSum += element.priceSubtotal *
              element.userProductUomQty *
              double.parse(r.result![0].displayName!.replaceAll("%", "")) /
              100;
          print("***************************************************");
        });
      } else {
        taxes.add(0.0);
      }
    });

    emit(SuccessGetTaxesState());
  }
}
