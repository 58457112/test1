import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyclassController extends GetxController {
  Future<void> addAppointment(
      DateTime selectedDay, int doctor_id, String time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';

    final chedy = Appointment(
      doctorId: doctor_id,
      appointmentDate:
          selectedDay.toString().substring(0, 10) + "T" + time + ":06.940Z",
    );

    try {
      // Map data = _users.toJson();
      final response = await http.post(
        Uri.parse(
            "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/patients/${id}/appointments"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: appointmentToJson(chedy),
      );
      if (response.statusCode == 204) {
        print('Received 204 response');
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
                  "'Appointment created successfully. Please check your email for more information. You will receive an email containing the link for an online consultation if you prefer a remote consultation. If you prefer an in-person consultation, you will also find your doctor's address in this email.',",
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
        ;

        print('Appointment created successfully.');

        print(token);
        print(selectedDay.toString().substring(0, 10) + time);
      } else {
        String errorMessage = response.body;
        String message = json.decode(errorMessage)['message'];
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
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
                  'Failed to create appointment',
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

        print(token);
        print(selectedDay.toString().substring(0, 10) + time);
        print(doctor_id);
        print(id);

        print(
            'Failed to create appointment. Error code: ${response.statusCode} + ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }
}

Appointment appointmentFromJson(String str) =>
    Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  Appointment({
    required this.doctorId,
    required this.appointmentDate,
  });

  int doctorId;
  String appointmentDate;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        doctorId: json["doctorId"],
        appointmentDate: (json["appointmentDate"]),
      );

  Map<String, dynamic> toJson() =>
      {"doctorId": doctorId, "appointmentDate": appointmentDate};
}
