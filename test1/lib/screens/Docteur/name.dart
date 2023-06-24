import 'dart:ui';
import 'package:test1/ressources/consts_global.dart';

import '../../controllers/fetchPatientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/GetRDVdOCTEUR.dart';
import '../../models/modelePatient.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  FetchPatientController fetchPatientController =
      Get.put(FetchPatientController());
  String name = "";
  String prenom = "";
  String tel = "";
  var data = Get.arguments;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      Sabri? patient = await fetchPatientController.getPatientFirstname(data);

      setState(() {
        name = patient!.firstName;
        prenom = patient.lastName;
        tel = patient.phoneNumber;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Here is the patient's information",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'font3',
                  fontWeight: FontWeight.bold,
                  color: solcolor1),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        "First Name",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font3'),
                      ),
                      subtitle: Text(
                        name,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Last Name",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font3'),
                      ),
                      subtitle: Text(
                        prenom,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "PhoneNumber",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font3'),
                      ),
                      subtitle: Text(
                        tel,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
