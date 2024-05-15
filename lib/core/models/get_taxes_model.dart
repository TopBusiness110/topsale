// To parse this JSON data, do
//
//     final getTaxesModel = getTaxesModelFromJson(jsonString);

import 'dart:convert';

GetTaxesModel getTaxesModelFromJson(String str) =>
    GetTaxesModel.fromJson(json.decode(str));

String getTaxesModelToJson(GetTaxesModel data) => json.encode(data.toJson());

class GetTaxesModel {
  int? count;
  dynamic prev;
  int? current;
  dynamic next;
  int? totalPages;
  List<TaxesNameData>? result;

  GetTaxesModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory GetTaxesModel.fromJson(Map<String, dynamic> json) => GetTaxesModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<TaxesNameData>.from(
                json["result"]!.map((x) => TaxesNameData.fromJson(x))),
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

class TaxesNameData {
  int? id;
  dynamic? displayName;

  TaxesNameData({
    this.id,
    this.displayName,
  });

  factory TaxesNameData.fromJson(Map<String, dynamic> json) => TaxesNameData(
        id: json["id"],
        displayName: json["display_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "display_name": displayName,
      };
}
