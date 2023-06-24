// To parse this JSON data, do
//
//     final factureModel = factureModelFromJson(jsonString);

import 'dart:convert';

List<FactureModel> factureModelFromJson(String str) => List<FactureModel>.from(
    json.decode(str).map((x) => FactureModel.fromJson(x)));

String factureModelToJson(List<FactureModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FactureModel {
  int id;
  String status;
  int appointmentId;
  int appointmentFee;
  DateTime creationDate;

  FactureModel({
    required this.id,
    required this.status,
    required this.appointmentId,
    required this.appointmentFee,
    required this.creationDate,
  });

  factory FactureModel.fromJson(Map<String, dynamic> json) => FactureModel(
        id: json["id"],
        status: json["status"],
        appointmentId: json["appointmentId"],
        appointmentFee: json["appointmentFee"],
        creationDate: DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "appointmentId": appointmentId,
        "appointmentFee": appointmentFee,
        "creationDate": creationDate.toIso8601String(),
      };
}
