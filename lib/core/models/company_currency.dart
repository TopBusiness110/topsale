// To parse this JSON data, do
//
//     final getCompanyCurrencyModel = getCompanyCurrencyModelFromJson(jsonString);

import 'dart:convert';

GetCompanyCurrencyModel getCompanyCurrencyModelFromJson(String str) => GetCompanyCurrencyModel.fromJson(json.decode(str));

String getCompanyCurrencyModelToJson(GetCompanyCurrencyModel data) => json.encode(data.toJson());

class GetCompanyCurrencyModel {
    int? count;
    dynamic prev;
    int? current;
    dynamic next;
    int? totalPages;
    List<CompanyCurrencyResult>? result;
    GetCompanyCurrencyModel({
        this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result,
    });

    factory GetCompanyCurrencyModel.fromJson(Map<String, dynamic> json) => GetCompanyCurrencyModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null ? [] : List<CompanyCurrencyResult>.from(json["result"]!.map((x) => CompanyCurrencyResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "prev": prev,
        "current": current,
        "next": next,
        "total_pages": totalPages,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class CompanyCurrencyResult {
    int? id;
    String? name;
    int? currencyId;

    CompanyCurrencyResult({
        this.id,
        this.name,
        this.currencyId,
    });

    factory CompanyCurrencyResult.fromJson(Map<String, dynamic> json) => CompanyCurrencyResult(
        id: json["id"],
        name: json["name"],
        currencyId: json["currency_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "currency_id": currencyId,
    };
}
