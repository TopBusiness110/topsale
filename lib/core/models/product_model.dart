

class ProductModel{
  String? name;
  double? price;
  String? image;
  int? quantity;
  String? code;
  int userOrderedQuantity;

  ProductModel({this.name, this.price, this.image, this.quantity , this.code,this.userOrderedQuantity=0});

  @override
  String toString() {
    return 'ProductModel{name: $name, price: $price, image: $image, quantity: $quantity, model: $code, userOrderedQuantity: $userOrderedQuantity}';
  }
}


