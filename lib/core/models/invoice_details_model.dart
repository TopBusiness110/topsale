// To parse this JSON data, do
//
//     final invoiceDetailsModel = invoiceDetailsModelFromJson(jsonString);

import 'dart:convert';

InvoiceDetailsModel invoiceDetailsModelFromJson(String str) => InvoiceDetailsModel.fromJson(json.decode(str));

String invoiceDetailsModelToJson(InvoiceDetailsModel data) => json.encode(data.toJson());

class InvoiceDetailsModel {
    int? id;
    String? name;

    InvoiceDetailsModel({
        this.id,
        this.name,
    });

    factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) => InvoiceDetailsModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
