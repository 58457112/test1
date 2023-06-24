// To parse this JSON data, do
//
//     final docteur1 = docteur1FromJson(jsonString);

import 'dart:convert';

Docteur1 docteur1FromJson(String str) => Docteur1.fromJson(json.decode(str));

String docteur1ToJson(Docteur1 data) => json.encode(data.toJson());

class Docteur1 {
  Docteur1({
    required this.items,
    required this.first,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.numberOfElements,
    required this.size,
    required this.number,
  });

  List<Item> items;
  bool first;
  bool last;
  int totalPages;
  int totalElements;
  int numberOfElements;
  int size;
  int number;

  factory Docteur1.fromJson(Map<String, dynamic> json) => Docteur1(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        first: json["first"],
        last: json["last"],
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        numberOfElements: json["numberOfElements"],
        size: json["size"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "first": first,
        "last": last,
        "totalPages": totalPages,
        "totalElements": totalElements,
        "numberOfElements": numberOfElements,
        "size": size,
        "number": number,
      };
}

class Item {
  Item({
    required this.id,
    required this.civility,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.specialityId,
    required this.availabilities,
    required this.iban,
    required this.bills,
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
  List<dynamic> availabilities;
  String iban;
  List<dynamic> bills;
  DateTime creationDate;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
        iban: json["iban"],
        bills: List<dynamic>.from(json["bills"].map((x) => x)),
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
        "iban": iban,
        "bills": List<dynamic>.from(bills.map((x) => x)),
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
