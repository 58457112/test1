import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/screens/LoginPage.dart';

import '../models/model_authlogin.dart';
import '../models/model_user.dart';
import '../models/model_user1.dart';
import '../screens/Docteur/navibar.dart';
import '../screens/patient/navigator.dart';

class AuthController extends GetxController {
  Future<void> Authentification(String email, String password) async {
    var _userAuth = UsersAuth(email: email, password: password);
    Map data = _userAuth.toJson();
    final response = await http.post(
      Uri.parse(
          "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/authenticate"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var token = jsonResponse['token'];
      var userid = jsonResponse['id'];

      var role = jsonResponse['role'];
      // Enregistrer le token dans les préférences de l'application
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      final id = await SharedPreferences.getInstance();
      await id.setInt('id', userid);
      print('chedyyy aaa : $userid');
      Get.to(() => role == 'DOCTOR' ? NavDoc() : Nav());
    } else {
      print('leeeeeee');
      print(response.body);

      //
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
                'Failed to login',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Text(
            "This email ${email} is not found ",
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
    }
  }

  //

  Future<void> registreDoc(
      String email,
      String pass,
      String firstName,
      String lastName,
      String civilite,
      String phone,
      String rib,
      int spec,
      String address) async {
    var _users = Docteur(
        email: email,
        password: pass,
        firstName: firstName,
        lastName: lastName,
        civility: civilite,
        phoneNumber: phone,
        specialityId: spec,
        address: address,
        iban: rib);
    Map data = _users.toJson();
    var response = await http.post(
        Uri.parse(
            "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data));

    print("add user : $data");

    if (response.statusCode == 201) {
      // var Response = json.decode(response.body);
      // var token = Response['token'];
      Get.to(() => LoginPage());
    } else {
      print(response.body);
      // print('lee');
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
                'Failed to register',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Text(
            "This email ${email} already exist",
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
    }
  }

  /// auth patient :
  ///
  ///
  Future<void> registrePatient(String email, String pass, String firstName,
      String lastName, String civilite, String phone) async {
    var _users = Users(
      email: email,
      password: pass,
      firstName: firstName,
      lastName: lastName,
      civility: civilite,
      phoneNumber: phone,
    );
    Map data = _users.toJson();
    var response = await http.post(
        Uri.parse(
            "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/patients"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data));

    print("add user : $data");

    if (response.statusCode == 201) {
      // var Response = json.decode(response.body);
      // var token = Response['token'];
      Get.to(() => LoginPage());
    } else {
      print(response.body);
      // print('lee');
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
                'Failed to register',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Text(
            "This email ${email} already exist",
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
    }
  }
}
