import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/core/remote/service_api.dart';

import '../../../core/models/all_prodyucts_model.dart';
import 'state.dart';

class ProductsOfCategoryCubit extends Cubit<ProductsOfCategoryState> {
  ProductsOfCategoryCubit(this.api) : super(ProductsOfCategoryInitial());

  ServiceApi api;
  AllProductsModel? allProductsModel;
  getAllProductsByCategory(int categoryId) async {
    emit(LoadingProductsOfCategoryInitial());
    final response = await api.getAllProductsByCategory(categoryId: categoryId);
    response.fold((l) {
      emit(ErrorProductsOfCategoryInitial());
    }, (r) {
      allProductsModel = r;
      emit(LoadedProductsOfCategoryInitial());
    });
  }
}
