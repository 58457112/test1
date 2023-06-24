import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/controllers/fetchPatientController.dart';
import 'package:test1/controllers/notificationControler.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:test1/screens/Docteur/EditPatient.dart';
import 'package:test1/screens/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:test1/models/modelePatient.dart';

import 'list/ListOfDoctors.dart';

class HomePatient extends StatefulWidget {
  const HomePatient({super.key});

  @override
  State<HomePatient> createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  int _selectedIndex = 0;
  Sabri? users;
  var isLoad = false;
  String? email;
  String? civilite;
  String name = "";
  List<Appointment> chedy = [];
  FetchPatientController fetchPatientController =
      Get.put(FetchPatientController());

  NotificationController notificationController =
      Get.put(NotificationController());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    getData();
    notificationController.todayAppointment();
    if (notificationController.comparison.value == true) {
      Get.snackbar("app", "app");
    }
  }

  getData() async {
    try {
      var fetchedUsers = await fetchPatientController.getPatient();
      setState(() {
        users = fetchedUsers;
        name = users!.firstName;
        civilite = users!.civility;
        isLoad = true;
      });
    } catch (e) {
      print(e);
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Accueil'),
    Text('Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 300),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditPatient()),
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
          Padding(
            padding: const EdgeInsets.only(right: 200, left: 30),
            child: Text(
              'Healthy Steps ',
              style: TextStyle(
                  fontSize: 22, color: solcolor1, fontFamily: 'font1'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Bonjour' + ' ' + civilite.toString() + ' ' + name.toString(),

            // concaténez les deux valeurs en une seule chaîne de caractères
            style: TextStyle(
              fontFamily: 'font3',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListOfDoctors()));
            },
            child: Container(
              width: 300,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 30, color: solcolor1),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Prendre rendez-vous avec un praticien',
                      style: TextStyle(fontSize: 18, fontFamily: 'font3'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 300,
            width: 430,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Container(
                color: Colors.white.withOpacity(0.95),
                child: Image(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/34/18/3d/34183dd6ae167ce65823b9756d96aa2b.jpg')),
              ),
            ),
          )
          // Text(
          //   'Mes Consultations',
          //   style: TextStyle(fontSize: 20, fontFamily: 'font3'),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             _onItemTapped(0);
          //           },
          //           child: Text(
          //             "Passées",
          //             style: TextStyle(
          //                 fontSize: 18,
          //                 fontFamily: 'font3',
          //                 color: _selectedIndex == 0 ? solcolor1 : Colors.grey),
          //           ),
          //         ),
          //         GestureDetector(
          //           onTap: () {
          //             _onItemTapped(1);
          //           },
          //           child: Text(
          //             "A venir",
          //             style: TextStyle(
          //                 fontSize: 18,
          //                 fontFamily: 'font3',
          //                 color: _selectedIndex == 1 ? solcolor1 : Colors.grey),
          //           ),
          //         ),
          //       ],
          //     ),
          //     SizedBox(
          //       height: 50,
          //     ),
          //     _selectedIndex == 0 ? Interface11() : Interface22(),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class Interface11 extends StatelessWidget {
  const Interface11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationController notificationController =
        Get.put(NotificationController());
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // ElevatedButton(
          //     onPressed: () {
          //       notificationController.todayAppointment();
          //       if (notificationController.comparison.value == true) {
          //         Get.snackbar("dsf", "dsfsd");
          //       }
          //     },
          //     child: Text("press")),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "' Vous n'avez pas encore réalise de consultation sur Healthy Steps'",
              style: TextStyle(
                  color: solcolor1, fontSize: 17, fontFamily: 'font3'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Ici s'affichera l'ensemble de vos consultation passées :détail(s) de la consultation ",
              style: TextStyle(fontFamily: 'font3', fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class Interface22 extends StatelessWidget {
  const Interface22({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 50, left: 50),
            child: Text(
              "' Vous n'avez aucune consultation prévue pour le moment '",
              style: TextStyle(
                  color: solcolor1, fontSize: 17, fontFamily: 'font3'),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Plus de 69 spécialités disponible en consultation Healthy Steps ",
              style: TextStyle(fontFamily: 'font3', fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// Future<String> getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('token') ?? '';
//   return token;
// }

Future<Sabri?> getUsers() async {
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
