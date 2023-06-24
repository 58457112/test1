// To parse this JSON data, do
//
//     final sabri = sabriFromJson(jsonString);

import 'dart:convert';

Sabri sabriFromJson(String str) => Sabri.fromJson(json.decode(str));

String sabriToJson(Sabri data) => json.encode(data.toJson());

class Sabri {
  int id;
  String civility;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  List<Appointment> appointments;
  DateTime creationDate;

  Sabri({
    required this.id,
    required this.civility,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.appointments,
    required this.creationDate,
  });

  factory Sabri.fromJson(Map<String, dynamic> json) => Sabri(
        id: json["id"],
        civility: json["civility"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        appointments: List<Appointment>.from(
            json["appointments"].map((x) => Appointment.fromJson(x))),
        creationDate: DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "civility": civility,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "appointments": List<dynamic>.from(appointments.map((x) => x.toJson())),
        "creationDate": creationDate.toIso8601String(),
      };
}

class Appointment {
  int id;
  String status;
  dynamic prescription;
  DateTime appointmentDate;
  int patientId; // Nouvelle propriété pour l'ID du patient
  int doctorId;

  Appointment(
      {required this.id,
      required this.status,
      this.prescription,
      required this.appointmentDate,
      required this.doctorId,
      required this.patientId});

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        status: json["status"],
        prescription: json["prescription"],
        appointmentDate: DateTime.parse(json["appointmentDate"]),
        doctorId: json["doctorId"],
        patientId: json["patientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "prescription": prescription,
        "appointmentDate": appointmentDate.toIso8601String(),
        "doctorId": doctorId,
        "patientId": patientId
      };
}
