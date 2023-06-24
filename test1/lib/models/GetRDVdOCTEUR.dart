// To parse this JSON data, do
//
//     final chedy = chedyFromJson(jsonString);

import 'dart:convert';

List<Chedy> chedyFromJson(String str) =>
    List<Chedy>.from(json.decode(str).map((x) => Chedy.fromJson(x)));

String chedyToJson(List<Chedy> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chedy {
  int id;
  String status;
  dynamic prescription;
  String appointmentDate;
  int patientId;

  Chedy({
    required this.id,
    required this.status,
    this.prescription,
    required this.appointmentDate,
    required this.patientId,
  });

  factory Chedy.fromJson(Map<String, dynamic> json) => Chedy(
        id: json["id"],
        status: json["status"],
        prescription: json["prescription"],
        appointmentDate: json["appointmentDate"],
        patientId: json["patientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "prescription": prescription,
        "appointmentDate": appointmentDate,
        "patientId": patientId,
      };
}
