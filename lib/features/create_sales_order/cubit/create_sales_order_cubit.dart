import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/models/all_journals_model.dart';
import 'package:topsale/core/models/all_prodyucts_model.dart';
import 'package:topsale/core/models/allusers_model.dart';
import 'package:topsale/core/models/defaul_model.dart';
import 'package:topsale/core/models/invoice_details_model.dart';
import 'package:topsale/core/models/product_model.dart';
import 'package:topsale/core/models/ware_house_model.dart';
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
    print(
        "hhhhhhhhhhhhhhhhhhhhhhhhhhhhh${context.read<ProductsCubit>().selectedProducts.length}");
    final response = await api.createSaleOrder(
        context.read<CreateSalesOrderCubit>().currentClientId,
        wareHouseSelectedValue??'');
    response.fold((l) {
      print('gggggggg');
      emit(FailureCreateSaleOrderState());
    }, (r) async {
      if (r.result != null) {
        createOrderModel = r;
        for (int i = 0;
            i < context.read<ProductsCubit>().selectedProducts.length;
            i++) {
          await createSaleOrderLine(context,
              productId: context.read<ProductsCubit>().selectedProducts[i].id!,
              productQuantity: context
                  .read<ProductsCubit>()
                  .selectedProducts[i]
                  .userOrderedQuantity,
              orderId: r.result!);
        }
      } else {}
    });

    emit(SuccessCreateSaleOrderState());
    // Navigator.pushNamedAndRemoveUntil(
    //     context, Routes.homeRoute, (route) => false);
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
  orderRelation(BuildContext context, {required partnerId}) async {
    emit(LoadingOrderRelationState());
    if (createOrderModel != null) {
      final response = await api.orderRelation(
        orderId: createOrderModel!.result,
      );
      response.fold((l) {
        emit(FailureOrderRelationState());
      }, (r) async {
        if (r.result != null) {
          orderRelationModel = r;
          if (getAccountMoveNumber(r.result.toString()) != null) {
            confirmInvoice(
              context,
              partnerId: partnerId,
              accountMoveNumber: getAccountMoveNumber(r.result.toString()),
            );
          }
          emit(SuccessOrderRelationState());
        } else {}
      });
    } else {
      print("nullll");
    }
  }

  DefaultModel? confirmInvoiceModel;
  confirmInvoice(BuildContext context,
      {required accountMoveNumber, required partnerId}) async {
    emit(LoadingConfirmInvoiceState());
    if (createOrderModel != null) {
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
                accountMoveNumber: getAccountMoveNumber(
                    orderRelationModel!.result.toString()));

          Navigator.pushReplacementNamed(context, Routes.receiptRoute);
          emit(SuccessConfirmInvoiceState());
        } else {}
      });
    } else {
      print("nullll");
    }
  }

  InvoiceDetailsModel? invoiceDetailsModel;
  getInvoiceDetails({required dynamic accountMoveNumber}) async {
    emit(LoadingGetInvoiceDetailsState());
    if (createOrderModel != null) {
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
    } else {
      print("nullll");
    }
  }
// createSaleOrder(
//   BuildContext context,
// ) async {
//   emit(LoadingCreateSaleOrderState());
//
//   final response = await api.createSaleOrder(currentClientId);
//   response.fold((l) {
//     print('gggggggg');
//
//     emit(FailureCreateSaleOrderState());
//   }, (r) async {
//     print('gggggggggggggggg');
//     if (r.result != null) {
//       createOrderModel = r;
//       emit(SuccessCreateSaleOrderState());
//     } else {}
//   });
// }
//
// DefaultModel? createOrderLineModel;
// createSaleOrderLine(BuildContext context,
//     {required int productId, required int productQuantity}) async {
//   emit(LoadingCreateSaleOrderLineState());
//   final response = await api.createSaleOrderLines(
//       orderId: createOrderModel!.result!,
//       productId: productId,
//       productQuantity: productQuantity);
//   response.fold((l) {
//     print('gggggggg');
//
//     emit(FailureCreateSaleOrderLineState());
//   }, (r) async {
//     print('gggggggggggggggg');
//     if (r.result != null) {
//       createOrderLineModel = r;
//       emit(SuccessCreateSaleOrderLineState());
//     } else {}
//   });
// }

//********** client *******************************
  selectClientName(String name, int id) {
    currentClient = name;
    currentClientId = id;
    print('ddddddddddd $currentClientId');
    emit(SelectingNameState());
  }

  AllUsersModel? allUsersModel;
  getAllUsers({
    int pageId = 1,
    bool isGetMore = false,
  }) async {
    isGetMore
        ? emit(Loading2GetAllUsersState())
        : emit(LoadingGetAllUsersState());
    matches.clear();

    final response = await api.getAllUsers(pageId, 15);
    response.fold((l) {
      emit(FailureGetAllUsersState());
    }, (r) {
      if (isGetMore) {
        allUsersModel = AllUsersModel(
          count: r.count,
          next: r.next,
          prev: r.prev,
          result: [...allUsersModel!.result!, ...r.result!],
        );
      } else {
        allUsersModel = r;
      }

      matches.addAll(allUsersModel!.result!);
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
    // if (product.qty_available! > product.userOrderedQuantity) {
    //product.userOrderedQuantity = product.userOrderedQuantity + 1;
    context.read<ProductsCubit>().addProduct(product: product);

    emit(AddProductState());
    //  }
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

  int wareHouseId = 0;

  selectJournalId(int value) {
    wareHouseId = value;
    emit(ChangingWareHouseState());
  }

  WareHouseModelResponse? allJournalsModel;
  getAllWareHouse() async {
    emit(LoadingGetJournalsState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getWareHouses();
    response.fold((l) => emit(FailureGetJournalsState()), (r) {
      emit(SuccessGetJournalsState());
      allJournalsModel = r;
      if(r.result!.isNotEmpty)
      selectPaymentMethod(r.result![0].id.toString());
      print("***************************************************");
      print(r.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }

  String? wareHouseSelectedValue;
  selectPaymentMethod(value) {
    wareHouseSelectedValue = value;
    print(wareHouseSelectedValue);
    emit(ChangingWareHouseState());
  }
}
