// To parse this JSON data, do
//
//     final updateDoctors = updateDoctorsFromJson(jsonString);

import 'dart:convert';

UpdateDoctors updateDoctorsFromJson(String str) =>
    UpdateDoctors.fromJson(json.decode(str));

String updateDoctorsToJson(UpdateDoctors data) => json.encode(data.toJson());

class UpdateDoctors {
  String? civility;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? address;
  String? password;
  int? specialityId;
  String? iban;

  UpdateDoctors({
    this.civility,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.password,
    this.specialityId,
    this.iban,
  });

  factory UpdateDoctors.fromJson(Map<String, dynamic> json) => UpdateDoctors(
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
