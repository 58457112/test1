import 'package:flutter/material.dart';
import 'package:test1/controllers/appointmentController.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:test1/screens/Docteur/dispo.dart';
import 'package:test1/screens/Docteur/DoctorAppointments.dart';
import 'package:test1/screens/Docteur/notes.dart';

import 'package:test1/screens/Docteur/EditPatient.dart';
import 'package:test1/screens/patient/HomePatient.dart';
import 'package:test1/screens/patient/Form.dart';
import 'package:test1/screens/patient/Help.dart';

import 'Facturepage.dart';
import 'HomeDoctor.dart';

class NavDoc extends StatefulWidget {
  const NavDoc({super.key});

  @override
  State<NavDoc> createState() => _NavDocState();
}

class _NavDocState extends State<NavDoc> {
  int currentIndex = 1;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List page = [Facture(), HomeDoctor(), Dispo()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          selectedItemColor: solcolor1,
          currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: "Facture",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              label: "Diponibilité",
            )
          ]),
      body: page[currentIndex],
    );
  }
}
