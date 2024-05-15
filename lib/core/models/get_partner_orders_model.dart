// To parse this JSON data, do
//
//     final getSaleOrderForPartnerModel = getSaleOrderForPartnerModelFromJson(jsonString);

import 'dart:convert';

GetSaleOrderForPartnerModel getSaleOrderForPartnerModelFromJson(String str) =>
    GetSaleOrderForPartnerModel.fromJson(json.decode(str));

String getSaleOrderForPartnerModelToJson(GetSaleOrderForPartnerModel data) =>
    json.encode(data.toJson());

class GetSaleOrderForPartnerModel {
  List<Result>? result;

  GetSaleOrderForPartnerModel({
    this.result,
  });

  factory GetSaleOrderForPartnerModel.fromJson(Map<String, dynamic> json) =>
      GetSaleOrderForPartnerModel(
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
  String? displayName;
  String? state;
  String? writeDate;
  dynamic? amountTotal;

  Result({
    this.id,
    this.displayName,
    this.state,
    this.writeDate,
    this.amountTotal,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        displayName: json["display_name"],
        state: json["state"],
        writeDate: json["write_date"],
        amountTotal: json["amount_total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "display_name": displayName,
        "state": state,
        "write_date": writeDate,
        "amount_total": amountTotal,
      };
}
