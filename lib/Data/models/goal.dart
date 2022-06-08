// To parse this JSON data, do
//
//     final goal = goalFromJson(jsonString);

import 'dart:convert';

Goal goalFromJson(String str) => Goal.fromJson(json.decode(str));

String goalToJson(Goal data) => json.encode(data.toJson());

class Goal {
  Goal({
  required  this.id,
    required this.userId,
    required this.goalId,
    required this.title,
    required  this.description,
    required this.checked,
    required this.createdAt,
    required this.updatedAt,
    required  this.v,
  });

  String id;
  String userId;
  int goalId;
  String title;
  String description;
  bool checked;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
    id: json["_id"],
    userId: json["userId"],
    goalId: json["id"],
    title: json["title"],
    description: json["description"],
    checked: json["checked"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "id": goalId,
    "title": title,
    "description": description,
    "checked": checked,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}