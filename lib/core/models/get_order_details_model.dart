// To parse this JSON data, do
//
//     final getOrderDetailsModel = getOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

GetManOrderDetailsModel getOrderDetailsModelFromJson(String str) =>
    GetManOrderDetailsModel.fromJson(json.decode(str));

String getOrderDetailsModelToJson(GetManOrderDetailsModel data) =>
    json.encode(data.toJson());

class GetManOrderDetailsModel {
  List<Result>? result;

  GetManOrderDetailsModel({
    this.result,
  });

  factory GetManOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetManOrderDetailsModel(
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  int? productId;
  String? name;
  dynamic? priceTax;
  dynamic? priceTotal;
  dynamic? priceSubtotal;
  dynamic? priceUnit;
   List<int>? taxesId;
  String? displayName;
  dynamic productUomQty;
  dynamic userProductUomQty;
  int? orderId;

  Result(
      {this.id,
      this.name,
      this.displayName,
      this.priceTax,
      this.priceTotal,this.taxesId,
      this.priceSubtotal,this.priceUnit,
      this.productUomQty,
      this.productId,
      this.orderId,
      this.userProductUomQty});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        displayName: json["display_name"],
        priceTax: json["price_tax"]?.toDouble(),
        priceTotal: json["price_total"]?.toDouble(),
        priceSubtotal: json["price_subtotal"]?.toDouble(),
        priceUnit: json["price_unit"]?.toDouble(),
        productUomQty: json["product_uom_qty"],taxesId: json["taxes_id"] == null
            ? []
            : List<int>.from(json["taxes_id"]!.map((x) => x)),
        userProductUomQty: json["product_uom_qty"],
        orderId: json["order_id"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "display_name": displayName,
        "price_tax": priceTax,
        "price_total": priceTotal,
        "price_subtotal": priceSubtotal,
        "price_unit": priceUnit,
        "product_uom_qty": productUomQty,
         "taxes_id":
            taxesId == null ? [] : List<dynamic>.from(taxesId!.map((x) => x)),
       
        "order_id": orderId,
        "product_id": productId,
      };
}
