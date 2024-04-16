// To parse this JSON data, do
//
//     final allUsersModel = allUsersModelFromJson(jsonString);

import 'dart:convert';

AllUsersModel allUsersModelFromJson(String str) => AllUsersModel.fromJson(json.decode(str));

String allUsersModelToJson(AllUsersModel data) => json.encode(data.toJson());

class AllUsersModel {
    int? count;
    dynamic prev;
    int? current;
    dynamic next;
    int? totalPages;
    List<UsersList>? result;

    AllUsersModel({
        this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result,
    });

    factory AllUsersModel.fromJson(Map<String, dynamic> json) => AllUsersModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null ? [] : List<UsersList>.from(json["result"]!.map((x) => UsersList.fromJson(x))),
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

class UsersList {
    int? id;
    String? name;
    dynamic phone;

    UsersList({
        this.id,
        this.name,
        this.phone,
    });

    factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
    };
}
