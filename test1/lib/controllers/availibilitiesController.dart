import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvailibilityController extends GetxController {
  Future<void> createAvailability(String start, String end) async {
    final availability = Availibility(
      startDate: start + "T09:00:00Z",
      endDate: end + "T18:00:00Z",
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';
    print(id);

    final response = await http.post(
      Uri.parse(
          "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors/${id}/availabilities"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: availibilityToJson(availability),
    );
    if (response.statusCode == 204) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50.0,
              ),
              SizedBox(height: 10.0),
              Text(
                "'Availibility created successfully.",
                style: TextStyle(fontFamily: "font3"),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                textStyle: TextStyle(
                  fontSize: 18.0,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
      );
      print('Availability created successfully.');
    } else {
      String errorMessage = response.body;
      String message = json.decode(errorMessage)['message'];
      Get.dialog(
        AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50.0,
              ),
              SizedBox(height: 10.0),
              Text(
                'Failed to create Availibility',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(fontFamily: 'font3'),
            textAlign: TextAlign.center,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                textStyle: TextStyle(
                  fontSize: 18.0,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
      );
      print(
          'Failed to create availability. Error code: ${response.statusCode}');
    }
    print(response.body);
  }
}

String availibilityToJson(Availibility data) => json.encode(data.toJson());

class Availibility {
  Availibility({
    required this.startDate,
    required this.endDate,
  });

  String startDate;
  String endDate;

  factory Availibility.fromJson(Map<String, dynamic> json) => Availibility(
        startDate: (json["startDate"]),
        endDate: (json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
      };
}
