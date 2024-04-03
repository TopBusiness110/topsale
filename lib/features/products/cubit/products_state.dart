part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class AddProductsState extends ProductsState {}

class RemoveProductsState extends ProductsState {}

class SearchingState extends ProductsState {}

class LoadingAllCategoriesState extends ProductsState {}

class AllCategoriesFailureState extends ProductsState {}

class AllCategoriesSuccessState extends ProductsState {}
class LoadingAllProductsState extends ProductsState {}

class AllProductsFailureState extends ProductsState {}

class AllProductsSuccessState extends ProductsState {}
