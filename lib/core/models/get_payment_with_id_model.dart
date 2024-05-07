// To parse this JSON data, do
//
//     final getPaymentWithIdModel = getPaymentWithIdModelFromJson(jsonString);

import 'dart:convert';

GetPaymentWithIdModel getPaymentWithIdModelFromJson(String str) => GetPaymentWithIdModel.fromJson(json.decode(str));

String getPaymentWithIdModelToJson(GetPaymentWithIdModel data) => json.encode(data.toJson());

class GetPaymentWithIdModel {
    List<Result>? result;

    GetPaymentWithIdModel({
        this.result,
    });

    factory GetPaymentWithIdModel.fromJson(Map<String, dynamic> json) => GetPaymentWithIdModel(
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    String? name;

    Result({
        this.name,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
