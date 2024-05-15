import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:topsale/core/models/get_taxes_model.dart';
import 'package:topsale/core/models/product_model.dart';
import 'package:topsale/core/remote/service_api.dart';

import '../../../core/models/all_prodyucts_model.dart';
import '../../../core/models/category_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.api) : super(ProductsInitial());
  ServiceApi api;
  List<ProductModelData> matches = [];
  List<ProductModelData> selectedProducts = [];
  List<double> taxes = [];

  addProduct({required ProductModelData product}) {
    print(
        "____________________selectedProducts.isEmpty __________________________");
    // product.userOrderedQuantity++;
    product.userOrderedQuantity++;
    if (selectedProducts.isEmpty) {
      selectedProducts.add(product);
    } else {
      bool isExist = false;

      for (int i = 0; i < selectedProducts.length; i++) {
        if (selectedProducts[i].id == product.id) {
          isExist = true;
          emit(AddProductsState());
        } else {
          // isExist = false;
        }
      }
      if (!isExist) {
        selectedProducts.add(product);
      }
    }

    emit(AddProductsState());
    return;
    // } else {
  }

  removeProduct({required ProductModelData product}) {
    if (product.userOrderedQuantity > 0) {
      product.userOrderedQuantity = product.userOrderedQuantity - 1;
      emit(RemoveProductsState());
    } else if (product.userOrderedQuantity == 0) {
      selectedProducts.remove(product);
      emit(RemoveProductsState());
    }
  }

  searchInProducts(String key, List<ProductModelData> products) {
    matches.clear();
    for (int i = 0; i < products.length; i++) {
      if (products[i].name!.toLowerCase().contains(key)) {
        matches.add(products[i]);
        emit(SearchingState());
      }
    }
  }

  GetTaxesModel? getTaxesModel;
  double taxesSum = 0;

  getTaxes() async {
    emit(LoadingGetTaxesState());
    taxes = [];
    taxesSum = 0;
    selectedProducts.forEach((element) async {
      if (element.taxesId!.isNotEmpty) {
        final response = await api.getTaxes(element.taxesId![0]);
        response.fold((l) => emit(FailureGetTaxesState()), (r) {
          taxes
              .add(double.parse(r.result![0].displayName!.replaceAll("%", "")));
          taxesSum += element.listPrice! *
              element.userOrderedQuantity *
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

  AllCategoriesModel? categoriesModel;
  getAllCategories() async {
    emit(LoadingAllCategoriesState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getAllCategories();
    response.fold((l) => emit(AllCategoriesFailureState()), (r) {
      emit(AllCategoriesSuccessState());
      categoriesModel = r;
      print("***************************************************");
      print(r);
      print("**************************${r.result}");
      // r.result!.map((e) => print(e.image1920));
    });
  }

  AllProductsModel? productsModel;
  getAllProducts({
    int pageId = 1,
    bool isGetMore = false,
  }) async {
    isGetMore
        ? emit(Loading2AllProductsState())
        : emit(LoadingAllProductsState());
    // emit(LoadingAllProductsState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getAllProducts(pageId);
    response.fold((l) => emit(AllProductsFailureState()), (r) {
      if (isGetMore) {
        productsModel = AllProductsModel(
          count: r.count,
          next: r.next,
          prev: r.prev,
          result: [...productsModel!.result!, ...r.result!],
        );
      } else {
        productsModel = r;
      }

      emit(AllProductsSuccessState());
      print("***************************************************");
      print(productsModel.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }

  TextEditingController searchController = TextEditingController();
  AllProductsModel? searchedproductsModel;
  searchProducts({
    int pageId = 1,
    bool isGetMore = false,
    required String productName,
  }) async {
    isGetMore
        ? emit(Loading2AllProductsState())
        : emit(LoadingAllProductsState());

    final response = await api.searchProducts(pageId, productName);
    response.fold((l) => emit(AllProductsFailureState()), (r) {
      if (isGetMore) {
        productsModel = AllProductsModel(
          count: r.count,
          next: r.next,
          prev: r.prev,
          result: [...productsModel!.result!, ...r.result!],
        );
      } else {
        searchedproductsModel = r;
      }

      emit(AllProductsSuccessState());

      print("***************************************************");
      print(productsModel.toString());
      print("**************************${r.result.toString()}");
      // r.result!.map((e) => print(e.image1920));
    });
  }
}
