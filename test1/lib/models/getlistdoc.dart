// To parse this JSON data, do
//
//     final rendezVous = rendezVousFromJson(jsonString);

import 'dart:convert';

RendezVous rendezVousFromJson(String str) =>
    RendezVous.fromJson(json.decode(str));

String rendezVousToJson(RendezVous data) => json.encode(data.toJson());

class RendezVous {
  RendezVous({
    required this.selectedDate,
    required this.selectedTime,
    required this.id,
  });

  DateTime selectedDate;
  String selectedTime;
  String id;

  factory RendezVous.fromJson(Map<String, dynamic> json) => RendezVous(
        selectedDate: DateTime.parse(json["selectedDate"]),
        selectedTime: json["selectedTime"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "selectedDate":
            "${selectedDate.year.toString().padLeft(4, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}",
        "selectedTime": selectedTime,
        "id": id,
      };
}
