import 'package:flutter/material.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:test1/screens/patient/HomePatient.dart';
import 'package:test1/screens/patient/Form.dart';
import 'package:test1/screens/patient/Help.dart';

import 'PatientAppointments.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int currentIndex = 1;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List page = [PatientAppointments(), HomePatient(), Help()];
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
              icon: Icon(Icons.list_alt_rounded),
              label: "Liste RDV",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Besoin d'aide ?",
            )
          ]),
      body: page[currentIndex],
    );
  }
}
