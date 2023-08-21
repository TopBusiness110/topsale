import 'package:topsale/core/models/product_model.dart';

class CartModel{
  String clientName ;
 List< ProductModel> listOfProducts;

  CartModel({required this.clientName, required this.listOfProducts});

  @override
  String toString() {
    return 'CartModel{clientName: $clientName, listOfProducts: $listOfProducts}';
  }
}