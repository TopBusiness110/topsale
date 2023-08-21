import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:topsale/features/cart/cart_model.dart';

import '../../core/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<CartModel> cart =[];

  addClients(String clientName , List<ProductModel> products){
    cart.add(CartModel(clientName: clientName ,listOfProducts: products));
    emit(ClientOrderAddedState());
    print(cart);
  }
}
