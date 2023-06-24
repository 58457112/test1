// To parse this JSON data, do
//
//     final docteur = docteurFromJson(jsonString);

import 'dart:convert';

Docteur docteurFromJson(String str) => Docteur.fromJson(json.decode(str));

String docteurToJson(Docteur data) => json.encode(data.toJson());

class Docteur {
  String civility;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String address;
  String password;
  int specialityId;
  String iban;

  Docteur({
    required this.civility,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.specialityId,
    required this.iban,
  });

  factory Docteur.fromJson(Map<String, dynamic> json) => Docteur(
        civility: json["civility"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        password: json["password"],
        specialityId: json["specialityId"],
        iban: json["iban"],
      );

  Map<String, dynamic> toJson() => {
        "civility": civility,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "password": password,
        "specialityId": specialityId,
        "iban": iban,
      };
}
