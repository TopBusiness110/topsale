// To parse this JSON data, do
//
//     final getCurrencyNameModel = getCurrencyNameModelFromJson(jsonString);

import 'dart:convert';

GetCurrencyNameModel getCurrencyNameModelFromJson(String str) => GetCurrencyNameModel.fromJson(json.decode(str));

String getCurrencyNameModelToJson(GetCurrencyNameModel data) => json.encode(data.toJson());

class GetCurrencyNameModel {
    int? count;
    dynamic prev;
    int? current;
    dynamic next;
    int? totalPages;
    List<CurrencyNameResult>? result;

    GetCurrencyNameModel({
        this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result,
    });

    factory GetCurrencyNameModel.fromJson(Map<String, dynamic> json) => GetCurrencyNameModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null ? [] : List<CurrencyNameResult>.from(json["result"]!.map((x) => CurrencyNameResult.fromJson(x))),
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

class CurrencyNameResult {
    int? id;
    String? name;

    CurrencyNameResult({
        this.id,
        this.name,
    });

    factory CurrencyNameResult.fromJson(Map<String, dynamic> json) => CurrencyNameResult(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
