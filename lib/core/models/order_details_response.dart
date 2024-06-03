// To parse this JSON data, do
//
//     final orderDetailsResponseModel = orderDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsResponseModel orderDetailsResponseModelFromJson(String str) => OrderDetailsResponseModel.fromJson(json.decode(str));

String orderDetailsResponseModelToJson(OrderDetailsResponseModel data) => json.encode(data.toJson());

class OrderDetailsResponseModel {
    int? count;
    dynamic prev;
    int? current;
    dynamic next;
    int? totalPages;
    List<Result>? result;

    OrderDetailsResponseModel({
        this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result,
    });

    factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) => OrderDetailsResponseModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "prev": prev,
        "current": current,
        "next": next,
        "total_pages": totalPages,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    String? name;
    int? productUomQty;
    double? priceTax;
    double? priceTotal;
    double? priceSubtotal;

    Result({
        this.name,
        this.productUomQty,
        this.priceTax,
        this.priceTotal,
        this.priceSubtotal,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        productUomQty: json["product_uom_qty"],
        priceTax: json["price_tax"]?.toDouble(),
        priceTotal: json["price_total"]?.toDouble(),
        priceSubtotal: json["price_subtotal"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "product_uom_qty": productUomQty,
        "price_tax": priceTax,
        "price_total": priceTotal,
        "price_subtotal": priceSubtotal,
    };
}
