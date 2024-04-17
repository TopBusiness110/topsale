// To parse this JSON data, do
//
//     final getAllJournalsModel = getAllJournalsModelFromJson(jsonString);

import 'dart:convert';

GetAllJournalsModel getAllJournalsModelFromJson(String str) => GetAllJournalsModel.fromJson(json.decode(str));

String getAllJournalsModelToJson(GetAllJournalsModel data) => json.encode(data.toJson());

class GetAllJournalsModel {
    int? count;
    dynamic prev;
    int? current;
    dynamic next;
    int? totalPages;
    List<Result>? result;

    GetAllJournalsModel({
        this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result,
    });

    factory GetAllJournalsModel.fromJson(Map<String, dynamic> json) => GetAllJournalsModel(
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
    int? id;
    String? displayName;

    Result({
        this.id,
        this.displayName,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        displayName: json["display_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "display_name": displayName,
    };
}
