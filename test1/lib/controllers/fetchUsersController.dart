import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/modeleDocteurById.dart';
import '../models/doctor.dart';

class FetchUsersController extends GetxController {
  Future<Docteurr?> getDoctor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';
    var client = http.Client();

    var uri = Uri.parse(
        "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors/$id");
    var response = await client.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var json1 = response.body;
      var user = Docteurr?.fromJson(json.decode(json1));
      return user;
    } else {
      print(response.statusCode);
      throw Exception("Failed to get users");
    }
  }

  //
  Future<Docteurr?> getDoctorName(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';
    var client = http.Client();

    var uri = Uri.parse(
        "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors/$id");
    var response = await client.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var json1 = response.body;
      var user = Docteurr?.fromJson(json.decode(json1));
      return user;
    } else {
      print(response.statusCode);
      throw Exception("Failed to get users");
    }
  }
}
