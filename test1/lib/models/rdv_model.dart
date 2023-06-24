// To parse this JSON data, do
//
//     final sabri = sabriFromJson(jsonString);

import 'dart:convert';

Sabri sabriFromJson(String str) => Sabri.fromJson(json.decode(str));

String sabriToJson(Sabri data) => json.encode(data.toJson());

class Sabri {
  Sabri({
    required this.firstName,
    required this.lastName,
    required this.dateRdv,
  });

  String firstName;
  String lastName;
  DateTime dateRdv;

  factory Sabri.fromJson(Map<String, dynamic> json) => Sabri(
        firstName: json["firstName"],
        lastName: json["lastName"],
        dateRdv: DateTime.parse(json["date_rdv"]),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "date_rdv": dateRdv.toIso8601String(),
      };
}
