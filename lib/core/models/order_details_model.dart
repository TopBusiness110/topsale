// To parse this JSON data, do
//
//     final getOrderDetailsModel = getOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

GetOrderDetailsModel getOrderDetailsModelFromJson(String str) =>
    GetOrderDetailsModel.fromJson(json.decode(str));

String getOrderDetailsModelToJson(GetOrderDetailsModel data) =>
    json.encode(data.toJson());

class GetOrderDetailsModel {
  int? count;
  dynamic prev;
  int? current;
  dynamic next;
  int? totalPages;
  List<Result>? result;

  GetOrderDetailsModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory GetOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetOrderDetailsModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "prev": prev,
        "current": current,
        "next": next,
        "total_pages": totalPages,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  String? name;
  dynamic? productUomQty;
  dynamic? priceTax;
  dynamic? priceTotal;
  dynamic? priceSubtotal;
  dynamic? displayName;
  dynamic? date;
  dynamic? id;
  dynamic? partnerId;
  dynamic state;

  Result(
      {this.name,
      this.productUomQty,
      this.priceTax,
      this.priceTotal,
      this.partnerId,
      this.priceSubtotal,
      this.date,
      this.displayName,this.state,
      this.id});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        state: json["state"],
        productUomQty: json["product_uom_qty"],
        date: json["create_date"],
        displayName: json["display_name"],
        id: json["order_id"],
        partnerId: json["order_partner_id"],
        priceTax: json["price_tax"]?.toDouble(),
        priceTotal: json["price_total"]?.toDouble(),
        priceSubtotal: json["price_subtotal"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "state": state,
        "product_uom_qty": productUomQty,
        "display_name": displayName,
        "create_date": date,
        "order_id": id,
        "order_partner_id": partnerId,
        "price_tax": priceTax,
        "price_total": priceTotal,
        "price_subtotal": priceSubtotal,
      };
}
