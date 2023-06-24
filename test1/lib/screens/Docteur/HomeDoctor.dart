import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/controllers/fetchUsersController.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:test1/screens/Docteur/DoctorAppointments.dart';
import 'package:test1/screens/Docteur/DoctorConsultation.dart';
import 'package:test1/screens/Docteur/EditDocteur.dart';
import 'package:test1/models/modeleDocteurById.dart';
import 'package:test1/screens/Docteur/EditPatient.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import '../patient/list/doctor.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:test1/screens/Docteur/Facturepage.dart';

class HomeDoctor extends StatefulWidget {
  const HomeDoctor({super.key});

  @override
  State<HomeDoctor> createState() => _HomePageDocState();
}

class _HomePageDocState extends State<HomeDoctor> {
  Docteurr? users;
  var isLoad = false;
  String? email;
  List<Availability> availabilities = [];
  String name = "";
  String civilite = "";
  FetchUsersController fetchUsersController = Get.put(FetchUsersController());
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var fetchedUsers = await fetchUsersController.getDoctor();
      setState(() {
        users = fetchedUsers;
        availabilities = users!.availabilities;
        name = users!.firstName;
        civilite = users!.civility;

        isLoad = true;
      });
    } catch (e) {
      print(e);
    }
  }

  // List<Availability> availabilities = [];
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE dd MMMM yyyy').format(now);

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: ListView(children: [
        SafeArea(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 300, top: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditDocteur()),
                  );
                },
                child: Text(
                  "Mon compte",
                  style: TextStyle(
                    fontFamily: 'font3',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200, left: 30, top: 2),
              child: Text(
                'Healthy Steps ',
                style: TextStyle(
                    fontSize: 22, color: solcolor1, fontFamily: 'font1'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              formattedDate,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15, fontFamily: 'font3'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // Text(
                  //   "I hope you're doing well " +
                  //       ' ' +
                  //       civilite.toString() +
                  //       ' ' +
                  //       name.toString(),
                  //   style: TextStyle(
                  //       fontFamily: 'font3', fontSize: 20, color: solcolor1),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(
                    height: 47,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50),
              child: Row(children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoctorAppointments()));
                  },
                  child: Container(
                    width: 150,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.list_alt, size: 30, color: solcolor1),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'List of appointments',
                            style: TextStyle(fontSize: 18, fontFamily: 'font3'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoctorConsultation()));
                  },
                  child: Container(
                    width: 150,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.list_alt, size: 30, color: solcolor1),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'List of consultations',
                            style: TextStyle(fontSize: 18, fontFamily: 'font3'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Each new day is a chance to make\n a difference in the lives of our patients, and I am grateful to be able to play a role in their journey towards healing and well-being.',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'font3', fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 220,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Container(
                  color: Colors.white.withOpacity(0.95),
                  child: Image(
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/d6/95/92/d69592f389e99d8341c4af7c7df63be2.jpg')),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )),
      ]),
    );
  }
}
