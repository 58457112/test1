// To parse this JSON data, do
//
//     final updatePatient = updatePatientFromJson(jsonString);

import 'dart:convert';

UpdatePatient updatePatientFromJson(String str) =>
    UpdatePatient.fromJson(json.decode(str));

String updatePatientToJson(UpdatePatient data) => json.encode(data.toJson());

class UpdatePatient {
  String? civility;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;

  UpdatePatient({
    this.civility,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
  });

  factory UpdatePatient.fromJson(Map<String, dynamic> json) => UpdatePatient(
        civility: json["civility"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "civility": civility,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
      };
}
