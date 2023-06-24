// To parse this JSON data, do
//
//     final docteurr = docteurrFromJson(jsonString);

import 'dart:convert';

Docteurr docteurrFromJson(String str) => Docteurr.fromJson(json.decode(str));

String docteurrToJson(Docteurr data) => json.encode(data.toJson());

class Docteurr {
  Docteurr({
    required this.id,
    required this.civility,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.specialityId,
    required this.availabilities,
    required this.creationDate,
  });

  int id;
  String civility;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;
  int specialityId;
  List<Availability> availabilities;
  DateTime creationDate;

  factory Docteurr.fromJson(Map<String, dynamic> json) => Docteurr(
        id: json["id"],
        civility: json["civility"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        specialityId: json["specialityId"],
        availabilities: List<Availability>.from(
            json["availabilities"].map((x) => Availability.fromJson(x))),
        creationDate: DateTime.parse(json["creationDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "civility": civility,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "specialityId": specialityId,
        "availabilities":
            List<dynamic>.from(availabilities.map((x) => x.toJson())),
        "creationDate": creationDate.toIso8601String(),
      };
}

class Availability {
  Availability({
    required this.id,
    required this.startDate,
    required this.endDate,
  });

  int id;
  DateTime startDate;
  DateTime endDate;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        id: json["id"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}
