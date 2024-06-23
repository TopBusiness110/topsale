// To parse this JSON data, do
//
//     final invoiceDetailsModel = invoiceDetailsModelFromJson(jsonString);

import 'dart:convert';

InvoiceDetailsModel invoiceDetailsModelFromJson(String str) =>
    InvoiceDetailsModel.fromJson(json.decode(str));

String invoiceDetailsModelToJson(InvoiceDetailsModel data) =>
    json.encode(data.toJson());

class InvoiceDetailsModel {
  int? id;
  String? name;
  int? partnerId;
  String? invoicePartnerDisplayName;
  dynamic? invoiceDate;
  String? state;
  dynamic? amountUntaxed;
  dynamic? amountTax;
  dynamic? amountTotal;
  dynamic? amountResidual;
  dynamic? paymentId;
  dynamic? paymentReference;

  InvoiceDetailsModel({
    this.id,
    this.name,
    this.partnerId,
    this.invoicePartnerDisplayName,
    this.invoiceDate,
    this.state,
    this.amountUntaxed,
    this.amountTax,
    this.amountTotal,
    this.amountResidual,this.paymentId,this.paymentReference
  });

  factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailsModel(
        id: json["id"],
        name: json["name"],
        partnerId: json["partner_id"],
        invoicePartnerDisplayName: json["invoice_partner_display_name"],
        invoiceDate: json["invoice_date"],
        state: json["state"],
        amountUntaxed: json["amount_untaxed"]?.toDouble(),
        amountTax: json["amount_tax"]?.toDouble(),
        amountTotal: json["amount_total"],
        amountResidual: json["amount_residual"],
        paymentId: json["payment_id"],
        paymentReference: json["payment_reference"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "partner_id": partnerId,
        "invoice_partner_display_name": invoicePartnerDisplayName,
        "invoice_date": invoiceDate,
        "state": state,
        "amount_untaxed": amountUntaxed,
        "amount_tax": amountTax,
        "amount_total": amountTotal,
        "amount_residual": amountResidual,
        "payment_id": paymentId,
        "payment_reference": paymentReference,
      };
}
