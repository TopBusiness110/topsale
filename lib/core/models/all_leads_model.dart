// To parse this JSON data, do
//
//     final getAllLeadsModel = getAllLeadsModelFromJson(jsonString);

import 'dart:convert';

GetAllLeadsModel getAllLeadsModelFromJson(String str) =>
    GetAllLeadsModel.fromJson(json.decode(str));

String getAllLeadsModelToJson(GetAllLeadsModel data) =>
    json.encode(data.toJson());

class GetAllLeadsModel {
  int? count;
  dynamic prev;
  int? current;
  dynamic next;
  int? totalPages;
  List<LeadsResult>? result;

  GetAllLeadsModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory GetAllLeadsModel.fromJson(Map<String, dynamic> json) =>
      GetAllLeadsModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<LeadsResult>.from(
                json["result"]!.map((x) => LeadsResult.fromJson(x))),
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

class LeadsResult {
  String? name;
  String? createDate;
  String? description;
  String? street;
  String? phone;

  LeadsResult({
    this.name,
    this.createDate,
    this.description,
    this.street,
    this.phone,
  });

  factory LeadsResult.fromJson(Map<String, dynamic> json) => LeadsResult(
        name: json["name"],
        createDate: json["create_date"],
        description: json["description"],
        street: json["street"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "create_date": createDate,
        "description": description,
        "street": street,
        "phone": phone,
      };
}
