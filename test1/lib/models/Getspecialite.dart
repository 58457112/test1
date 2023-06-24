// To parse this JSON data, do
//
//     final spec = specFromJson(jsonString);

import 'dart:convert';

List<Spec> specFromJson(String str) =>
    List<Spec>.from(json.decode(str).map((x) => Spec.fromJson(x)));

String specToJson(List<Spec> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Spec {
  Spec({
    required this.id,
    required this.name,
    required this.appointmentDuration,
  });

  int id;
  String name;
  int appointmentDuration;

  factory Spec.fromJson(Map<String, dynamic> json) => Spec(
        id: json["id"],
        name: json["name"],
        appointmentDuration: json["appointmentDuration"],
      );

  static List<Spec> specListFromJson(List<dynamic> list) {
    List<Spec> rows = list.map((i) => Spec.fromJson(i)).toList();
    return rows;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "appointmentDuration": appointmentDuration,
      };
}
