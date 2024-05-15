// To parse this JSON data, do
//
//     final getPaymentByIdModel = getPaymentByIdModelFromJson(jsonString);

import 'dart:convert';

GetPaymentByIdModel getPaymentByIdModelFromJson(String str) =>
    GetPaymentByIdModel.fromJson(json.decode(str));

String getPaymentByIdModelToJson(GetPaymentByIdModel data) =>
    json.encode(data.toJson());

class GetPaymentByIdModel {
  int? count;
  dynamic prev;
  int? current;
  dynamic next;
  int? totalPages;
  List<PaymentResult>? result;

  GetPaymentByIdModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory GetPaymentByIdModel.fromJson(Map<String, dynamic> json) =>
      GetPaymentByIdModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<PaymentResult>.from(
                json["result"]!.map((x) => PaymentResult.fromJson(x))),
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

class PaymentResult {
  int? moveId;
  dynamic? name;

  PaymentResult({
    this.moveId,
    this.name,
  });

  factory PaymentResult.fromJson(Map<String, dynamic> json) => PaymentResult(
        moveId: json["move_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "move_id": moveId,
        "name": name,
      };
}
