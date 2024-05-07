// To parse this JSON data, do
//
//     final getOrderDetailsModel = getOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

GetOrderDetailsModel getOrderDetailsModelFromJson(String str) => GetOrderDetailsModel.fromJson(json.decode(str));

String getOrderDetailsModelToJson(GetOrderDetailsModel data) => json.encode(data.toJson());

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

    factory GetOrderDetailsModel.fromJson(Map<String, dynamic> json) => GetOrderDetailsModel(
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
    dynamic? productUomQty;
    dynamic? productUom;

    Result({
        this.name,
        this.productUomQty,
        this.productUom,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        productUomQty: json["product_uom_qty"],
        productUom: json["product_uom"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "product_uom_qty": productUomQty,
        "product_uom": productUom,
    };
}
