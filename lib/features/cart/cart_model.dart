import 'package:topsale/core/models/all_prodyucts_model.dart';
import 'package:topsale/core/models/product_model.dart';

class CartModel{
  String clientName ;
 List< ProductModelData> listOfProducts;

  CartModel({required this.clientName, required this.listOfProducts});

  @override
  String toString() {
    return 'CartModel{clientName: $clientName, listOfProducts: $listOfProducts}';
  }
}