// To parse this JSON data, do
//
//     final updatePaymentStateModel = updatePaymentStateModelFromJson(jsonString);

import 'dart:convert';

UpdatePaymentStateModel updatePaymentStateModelFromJson(String str) => UpdatePaymentStateModel.fromJson(json.decode(str));

String updatePaymentStateModelToJson(UpdatePaymentStateModel data) => json.encode(data.toJson());

class UpdatePaymentStateModel {
    String? jsonrpc;
    dynamic id;
    bool? result;

    UpdatePaymentStateModel({
        this.jsonrpc,
        this.id,
        this.result,
    });

    factory UpdatePaymentStateModel.fromJson(Map<String, dynamic> json) => UpdatePaymentStateModel(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result,
    };
}
