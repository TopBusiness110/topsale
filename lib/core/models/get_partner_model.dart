// To parse this JSON data, do
//
//     final getPartnerDetailsModel = getPartnerDetailsModelFromJson(jsonString);

import 'dart:convert';

GetPartnerDetailsModel getPartnerDetailsModelFromJson(String str) =>
    GetPartnerDetailsModel.fromJson(json.decode(str));

String getPartnerDetailsModelToJson(GetPartnerDetailsModel data) =>
    json.encode(data.toJson());

class GetPartnerDetailsModel {
  String? name;
  dynamic? userId;
  dynamic? totalOverdue;
  dynamic? totalDue;
  List<dynamic>? saleOrderIds;

  GetPartnerDetailsModel({
    this.name,
    this.userId,
    this.totalOverdue,
    this.totalDue,
    this.saleOrderIds,
  });

  factory GetPartnerDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetPartnerDetailsModel(
        name: json["name"],
        userId: json["user_id"],
        totalOverdue: json["total_overdue"],
        totalDue: json["total_due"],
        saleOrderIds: json["sale_order_ids"] == null
            ? []
            : List<int>.from(json["sale_order_ids"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "user_id": userId,
        "total_overdue": totalOverdue,
        "total_due": totalDue,
        "sale_order_ids": saleOrderIds == null
            ? []
            : List<dynamic>.from(saleOrderIds!.map((x) => x)),
      };
}
