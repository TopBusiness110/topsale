// To parse this JSON data, do
//
//     final getCompanyCurrencyModel = getCompanyCurrencyModelFromJson(jsonString);

import 'dart:convert';

GetCompanyDataModel getCompanyCurrencyModelFromJson(String str) =>
    GetCompanyDataModel.fromJson(json.decode(str));

String getCompanyCurrencyModelToJson(GetCompanyDataModel data) =>
    json.encode(data.toJson());

class GetCompanyDataModel {
  int? count;
  dynamic prev;
  int? current;
  dynamic next;
  int? totalPages;
  List<CompanyCurrencyResult>? result;
  GetCompanyDataModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory GetCompanyDataModel.fromJson(Map<String, dynamic> json) =>
      GetCompanyDataModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<CompanyCurrencyResult>.from(
                json["result"]!.map((x) => CompanyCurrencyResult.fromJson(x))),
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
class CompanyCurrencyResult {
    int? id;
    String? name;
    String? street;
    String? countryCode;
    int? currencyId;
    int? accountSaleTaxId;
    String? vat;
    String? companyRegistry;
    String? logo;

    CompanyCurrencyResult({
        this.id,
        this.name,
        this.street,
        this.countryCode,
        this.currencyId,
        this.accountSaleTaxId,
        this.vat,
        this.companyRegistry,
        this.logo,
    });

    factory CompanyCurrencyResult.fromJson(Map<String, dynamic> json) => CompanyCurrencyResult(
        id: json["id"],
        name: json["name"],
        street: json["street"],
        countryCode: json["country_code"],
        currencyId: json["currency_id"],
        accountSaleTaxId: json["account_sale_tax_id"],
        vat: json["vat"],
        companyRegistry: json["company_registry"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "street": street,
        "country_code": countryCode,
        "currency_id": currencyId,
        "account_sale_tax_id": accountSaleTaxId,
        "vat": vat,
        "company_registry": companyRegistry,
        "logo": logo,
    };
}
