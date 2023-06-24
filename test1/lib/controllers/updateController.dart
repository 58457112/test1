import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:test1/models/emailreset.dart';
import 'package:test1/models/modele%20updatePatient.dart';
import 'package:test1/models/updatedOctor.dart';
import 'package:test1/screens/LoginPage.dart';
import '../models/model_authlogin.dart';
import '../models/model_user.dart';
import '../models/updatePass.dart';
import '../screens/UpdatePassword.dart';

class UpdateController extends GetxController {
  Future<void> UpdateDoctor(String Email, String firstname, String lastnamen,
      String Password, String Phonenumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';

    var _users = UpdateDoctors(email: Email);

    if (firstname.isNotEmpty) {
      _users.firstName = firstname;
    }
    if (lastnamen.isNotEmpty) {
      _users.lastName = lastnamen;
    }
    if (Password.isNotEmpty) {
      _users.password = Password;
    }
    if (Phonenumber.isNotEmpty) {
      _users.phoneNumber = Phonenumber;
    }

    Map<String, dynamic> data = _users.toJson();

    var response = await http.put(
      Uri.parse(
          "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/doctors/$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode(data),
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
                "The data has been changed successfully",
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
      print('succès');
    } else {
      print('erreur');
    }

    print("response " + response.statusCode.toString());
    print(data);
  }

  Future<void> UpdateUser(String Email, String Password, String FirstName,
      String PhoneNumber, String LastName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? '';
    var _users = UpdatePatient(
      email: Email,
      firstName: FirstName,
      lastName: LastName,
      password: Password,
      phoneNumber: PhoneNumber,
    );

    Map data = _users.toJson();
    var response = await http.put(
        Uri.parse(
            "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/patients$id"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: json.encode(data));
    if (response.statusCode == 204) {
      print('succes ');
    } else {
      print('errroooor');
    }
    print("response" + response.statusCode.toString());
    print(response.body);

    print(data);
  }

  Future<void> emailReset(String email) async {
    var _userAuth = Resetemail(email: email);
    Map data = _userAuth.toJson();
    print(data);
    final response = await http.post(
      Uri.parse(
          "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/forgot-password"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 204) {
      print('succes');
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
                "Check your email",
                style: TextStyle(fontFamily: "font3"),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => UpdatePassword());
                // Get.back();
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

      // Enregistrer le token dans les préférences de l'application

    } else {
      print('erreeur');
      print(response.body);

      //
    }
  }

  Future<void> updatePassword(String Password, String code) async {
    var _userAuth = UpdatePass(password: Password, token: code);
    Map data = _userAuth.toJson();
    print(data);
    final response = await http.post(
      Uri.parse(
          "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/reset-password"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    print(response.body);
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
                "Your password has been changed succesfully",
                style: TextStyle(fontFamily: "font3"),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => LoginPage());
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

      print(response.body);
      print('succes');

      // Enregistrer le token dans les préférences de l'application

    } else {
      print(response.body);
      print('erreeur');
      print(response.body);

      //
    }
  }
}
