// To parse this JSON data, do
//
//     final getLocationModel = getLocationModelFromJson(jsonString);

import 'dart:convert';

GetLocationModel getLocationModelFromJson(String str) => GetLocationModel.fromJson(json.decode(str));

String getLocationModelToJson(GetLocationModel data) => json.encode(data.toJson());

class GetLocationModel {
    int? count;
    dynamic prev;
    int? current;
    dynamic next;
    int? totalPages;
    List<LocationsResult>? result;

    GetLocationModel({
        this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result,
    });

    factory GetLocationModel.fromJson(Map<String, dynamic> json) => GetLocationModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null ? [] : List<LocationsResult>.from(json["result"]!.map((x) => LocationsResult.fromJson(x))),
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

class LocationsResult {
    int? id;
    String? name;

    LocationsResult({
        this.id,
        this.name,
    });

    factory LocationsResult.fromJson(Map<String, dynamic> json) => LocationsResult(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
