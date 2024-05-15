// To parse this JSON data, do
//
//     final getPaymentWithIdModel = getPaymentWithIdModelFromJson(jsonString);

import 'dart:convert';

GetPaymentWithIdModel getPaymentWithIdModelFromJson(String str) => GetPaymentWithIdModel.fromJson(json.decode(str));

String getPaymentWithIdModelToJson(GetPaymentWithIdModel data) => json.encode(data.toJson());

class GetPaymentWithIdModel {
    List<PaymentResult>? result;

    GetPaymentWithIdModel({
        this.result,
    });

    factory GetPaymentWithIdModel.fromJson(Map<String, dynamic> json) => GetPaymentWithIdModel(
        result: json["result"] == null ? [] : List<PaymentResult>.from(json["result"]!.map((x) => PaymentResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class PaymentResult {
    String? name;
    PaymentResult({
        this.name,
    });

    factory PaymentResult.fromJson(Map<String, dynamic> json) => PaymentResult(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
