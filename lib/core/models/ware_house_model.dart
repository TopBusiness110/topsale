// To parse this JSON data, do
//
//     final wareHouseModelResponse = wareHouseModelResponseFromJson(jsonString);

import 'dart:convert';

WareHouseModelResponse wareHouseModelResponseFromJson(String str) =>
    WareHouseModelResponse.fromJson(json.decode(str));

String wareHouseModelResponseToJson(WareHouseModelResponse data) =>
    json.encode(data.toJson());

class WareHouseModelResponse {
  List<Result>? result;

  WareHouseModelResponse({
    this.result,
  });

  factory WareHouseModelResponse.fromJson(Map<String, dynamic> json) =>
      WareHouseModelResponse(
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
  String? name;

  Result({
    this.id,
    this.name,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
