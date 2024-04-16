// To parse this JSON data, do
//
//     final getAllOrdersModel = getAllOrdersModelFromJson(jsonString);

import 'dart:convert';

GetAllOrdersModel getAllOrdersModelFromJson(String str) =>
    GetAllOrdersModel.fromJson(json.decode(str));

String getAllOrdersModelToJson(GetAllOrdersModel data) =>
    json.encode(data.toJson());

class GetAllOrdersModel {
  dynamic? count;
  dynamic prev;
  dynamic? current;
  dynamic next;
  dynamic? totalPages;
  List<OrdersData>? result;

  GetAllOrdersModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory GetAllOrdersModel.fromJson(Map<String, dynamic> json) =>
      GetAllOrdersModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<OrdersData>.from(
                json["result"]!.map((x) => OrdersData.fromJson(x))),
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

class OrdersData {
  int? id;
  int? partnerId;
  String? displayName;
  String? state;
  String? writeDate;
  String? partnerName;
  dynamic? amountTotal;

  OrdersData({
    this.id,
    this.partnerId,
    this.displayName,
    this.state,
    this.writeDate,
    this.partnerName='',
    this.amountTotal,
  });

  factory OrdersData.fromJson(Map<String, dynamic> json) => OrdersData(
        id: json["id"],
        partnerId: json["partner_id"],
        displayName: json["display_name"],
        state: json["state"],
        writeDate: json["write_date"],
        amountTotal: json["amount_total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "partner_id": partnerId,
        "display_name": displayName,
        "state": state,
        "write_date": writeDate,
        "amount_total": amountTotal,
      };
}
