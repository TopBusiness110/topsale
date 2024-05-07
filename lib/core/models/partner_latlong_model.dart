// To parse this JSON data, do
//
//     final getPartnerLatLongModel = getPartnerLatLongModelFromJson(jsonString);

import 'dart:convert';

GetPartnerLatLongModel getPartnerLatLongModelFromJson(String str) => GetPartnerLatLongModel.fromJson(json.decode(str));

String getPartnerLatLongModelToJson(GetPartnerLatLongModel data) => json.encode(data.toJson());

class GetPartnerLatLongModel {
    int? count;
    dynamic prev;
    int? current;
    dynamic next;
    int? totalPages;
    List<Result>? result;

    GetPartnerLatLongModel({
        this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result,
    });

    factory GetPartnerLatLongModel.fromJson(Map<String, dynamic> json) => GetPartnerLatLongModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
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

class Result {
    String? name;
    double? partnerLatitude;
    double? partnerLongitude;

    Result({
        this.name,
        this.partnerLatitude,
        this.partnerLongitude,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        partnerLatitude: json["partner_latitude"]?.toDouble(),
        partnerLongitude: json["partner_longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "partner_latitude": partnerLatitude,
        "partner_longitude": partnerLongitude,
    };
}
