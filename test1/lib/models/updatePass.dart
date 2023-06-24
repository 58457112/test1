// To parse this JSON data, do
//
//     final updatePass = updatePassFromJson(jsonString);

import 'dart:convert';

UpdatePass updatePassFromJson(String str) =>
    UpdatePass.fromJson(json.decode(str));

String updatePassToJson(UpdatePass data) => json.encode(data.toJson());

class UpdatePass {
  String token;
  String password;

  UpdatePass({
    required this.token,
    required this.password,
  });

  factory UpdatePass.fromJson(Map<String, dynamic> json) => UpdatePass(
        token: json["token"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "password": password,
      };
}
