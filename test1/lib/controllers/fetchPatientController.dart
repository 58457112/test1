import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/modelePatient.dart';

class FetchPatientController extends GetxController {
  Future<Sabri?> getPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';
    var client = http.Client();
    // var token = await getToken();
    // var token =
    //     "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjaGVkeTExMTFAZ21haWwuY29tIiwiZXhwIjoxNjc4ODQ2MTUwLCJpYXQiOjE2Nzg4MjgxNTB9.alTWnzou5E3GCDU60K52vlqHu6DgNJ1L9T6O3KVVS9d3oSyF5FBkjX5dieVZcZ27t927FjCV8L8cpTSg_C_r4Q";
    var uri = Uri.parse(
        "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/patients/$id");
    var response = await client.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var json1 = response.body;
      var user = Sabri?.fromJson(json.decode(json1));
      return user;
    } else {
      print(response.statusCode);
      throw Exception("Failed to get users");
    }
  }

  Future<Sabri?> getPatientFirstname(int patientId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';
    var client = http.Client();
    // var token = await getToken();
    // var token =
    //     "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjaGVkeTExMTFAZ21haWwuY29tIiwiZXhwIjoxNjc4ODQ2MTUwLCJpYXQiOjE2Nzg4MjgxNTB9.alTWnzou5E3GCDU60K52vlqHu6DgNJ1L9T6O3KVVS9d3oSyF5FBkjX5dieVZcZ27t927FjCV8L8cpTSg_C_r4Q";
    var uri = Uri.parse(
        "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/patients/$patientId");
    var response = await client.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var json1 = response.body;
      var user = Sabri?.fromJson(json.decode(json1));
      return user;
    } else {
      print(response.statusCode);
      throw Exception("Failed to get users");
    }
  }

  Future<void> Cancell(int doctorId, int appointmentId, String Reason) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final Map<String, dynamic> requestBody = {
      'cancellationReason': Reason,
    };
    final String requestBodyJson = json.encode(requestBody);
    final response = await http.post(
      Uri.parse(
          "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors/$doctorId/appointments/$appointmentId/do-cancel"),
      headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json'
      },
      body: requestBodyJson,
    );
    print(" hedhaa ee  $doctorId");
    print(appointmentId);
    print("hedha e reason : $Reason");
    print(requestBody);
    if (response.statusCode == 204) {
      print('ilyeeey');
    } else {
      print('maha2ah');
      print(response.statusCode);
      String errorMessage = response.body;
      String message = json.decode(errorMessage)['message'];
    }
  }
}
