// To parse this JSON data, do
//
//     final orderInvoiceDetailsModel = orderInvoiceDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderInvoiceDetailsModel orderInvoiceDetailsModelFromJson(String str) => OrderInvoiceDetailsModel.fromJson(json.decode(str));

String orderInvoiceDetailsModelToJson(OrderInvoiceDetailsModel data) => json.encode(data.toJson());

class OrderInvoiceDetailsModel {
    
    List<Result>? result;

    OrderInvoiceDetailsModel({
      
        this.result,
    });

    factory OrderInvoiceDetailsModel.fromJson(Map<String, dynamic> json) => OrderInvoiceDetailsModel(
   
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
   
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    int? id;
    String? name;
    String? invoiceDate;
    String? paymentState;
    dynamic? paymentInvoice;
    dynamic? paymentId;


    Result({
        this.id,
        this.name,
        this.invoiceDate,
        this.paymentState,this.paymentId,this.paymentInvoice
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        invoiceDate: json["invoice_date"],
        paymentState: json["payment_state"],
        paymentId: json["payment_id"],
        paymentInvoice: json["payment_reference"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "invoice_date": invoiceDate,
        "payment_state": paymentState,
        "payment_reference": paymentInvoice,
        "payment_id": paymentId,
    };
}
