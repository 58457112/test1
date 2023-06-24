import 'package:flutter/material.dart';
import 'package:test1/screens/Docteur/EditDocteur.dart';
import 'package:test1/screens/Docteur/EditPatient.dart';

import 'screens/Docteur/HomeDoctor.dart';

import 'screens/patient/Form.dart';
import 'screens/patient/Help.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 1;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List page = [EditDocteur(), HomeDoctor(), EditPatient()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_rounded), label: "hhh"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
      body: page[currentIndex],
    );
  }
}
