import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test1/models/GetRDVdOCTEUR.dart';
import 'package:test1/models/facture%20modele.dart';
import 'package:test1/screens/Docteur/Facturepage.dart';
import '../models/doctor.dart';
import 'package:flutter/material.dart';

class FetchDoctorsController extends GetxController {
  Future<Docteur1?> getDoctors(
      int size, int specialityid, String availibility) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';
    var client = http.Client();
    http: //clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors?page=0&size=10&specialityId=1&availableWithinNext=TODAY
    var uri = Uri.parse(
        "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors?page=$size&size=5&specialityId=$specialityid&availableWithinNext=$availibility");

    var response = await client.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var json1 = response.body;
      var user = Docteur1?.fromJson(json.decode(json1));
      return user;
    } else {
      throw Exception("Failed to get users");
    }
  }

  Future<List<Chedy>> getDoctorappointment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';
    var client = http.Client();

    var uri = Uri.parse(
        "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors/$id/appointments");

    var response = await client.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(response.statusCode);
      var json1 = response.body;
      List<dynamic> list = json.decode(json1);
      List<Chedy> users = list.map((data) => Chedy.fromJson(data)).toList();
      print([list]);
      return users;
    } else {
      throw Exception("Failed to get users");
    }
  }

  Future<List<FactureModel>> getDoctorFacture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';
    var client = http.Client();

    var uri = Uri.parse(
        "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors/$id/bills");
    print(id);
    var response = await client.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse is List) {
        List<FactureModel> factures =
            jsonResponse.map((data) => FactureModel.fromJson(data)).toList();
        return factures;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      print(response.statusCode);
      throw Exception("Failed to get factures");
    }
  }

  Future<void> Done(int appointmentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;
    final Map<String, dynamic> requestBody = {
      'doctorId': id,
      ' appointmentId': appointmentId
    };
    final String requestBodyJson = json.encode(requestBody);
    final response = await http.post(
      Uri.parse(
          "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors/$id/appointments/$appointmentId/do-approve"),
      headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json'
      },
      body: requestBodyJson,
    );

    print(appointmentId);

    print(requestBody);
    if (response.statusCode == 204) {
      print('ilyeeey');
    } else {
      print('maha2ah');
      print(response.statusCode);
      print(response.body);
      String errorMessage = response.body;
      String message = json.decode(errorMessage)['message'];
    }
  }

  Future<void> Prescription(String prescription, int appointmentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int id = prefs.getInt('id') ?? 0;
    final Map<String, dynamic> requestBody = {
      'prescription': prescription,
    };
    final String requestBodyJson = json.encode(requestBody);
    final response = await http.post(
      Uri.parse(
          "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors/$id/appointments/$appointmentId/do-approve"),
      headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json'
      },
      body: requestBodyJson,
    );

    print(appointmentId);

    print(requestBody);
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
                "The prescription is saved",
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
      print('ilyeeey');
    } else {
      print('maha2ah');
      print(response.statusCode);
      print(response.body);
      String errorMessage = response.body;
      String message = json.decode(errorMessage)['message'];
    }
  }
}
