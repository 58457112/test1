// To parse this JSON data, do
//
//     final usersAuth = usersAuthFromJson(jsonString);

import 'dart:convert';

UsersAuth usersAuthFromJson(String str) => UsersAuth.fromJson(json.decode(str));

String usersAuthToJson(UsersAuth data) => json.encode(data.toJson());

class UsersAuth {
  UsersAuth({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory UsersAuth.fromJson(Map<String, dynamic> json) => UsersAuth(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
