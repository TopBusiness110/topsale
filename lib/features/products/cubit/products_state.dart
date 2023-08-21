part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}
class AddProductsState extends ProductsState {}
class RemoveProductsState extends ProductsState {}
class SearchingState extends ProductsState {}
