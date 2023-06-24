// To parse this JSON data, do
//
//     final rendezVous = rendezVousFromJson(jsonString);

import 'dart:convert';

RendezVous rendezVousFromJson(String str) =>
    RendezVous.fromJson(json.decode(str));

String rendezVousToJson(RendezVous data) => json.encode(data.toJson());

class RendezVous {
  RendezVous({
    required this.dateRdv,
    required this.id,
    required this.selectedDate,
    required this.selectedTime,
  });

  String dateRdv;
  String id;
  DateTime selectedDate;
  String selectedTime;

  factory RendezVous.fromJson(Map<String, dynamic> json) => RendezVous(
        dateRdv: json["date_rdv"],
        id: json["id"],
        selectedDate: DateTime.parse(json["selectedDate"]),
        selectedTime: json["selectedTime"],
      );

  Map<String, dynamic> toJson() => {
        "date_rdv": dateRdv,
        "id": id,
        "selectedDate":
            "${selectedDate.year.toString().padLeft(4, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}",
        "selectedTime": selectedTime,
      };
}
