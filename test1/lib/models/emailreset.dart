// To parse this JSON data, do
//
//     final resetemail = resetemailFromJson(jsonString);

import 'dart:convert';

Resetemail resetemailFromJson(String str) =>
    Resetemail.fromJson(json.decode(str));

String resetemailToJson(Resetemail data) => json.encode(data.toJson());

class Resetemail {
  String email;

  Resetemail({
    required this.email,
  });

  factory Resetemail.fromJson(Map<String, dynamic> json) => Resetemail(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
