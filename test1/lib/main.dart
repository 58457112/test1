// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:test1/screens/Docteur/Facturepage.dart';
import 'package:test1/screens/Docteur/dispo.dart';
import 'package:test1/screens/Docteur/Appointments.dart';
import 'package:test1/screens/Docteur/navibar.dart';
import 'package:test1/screens/Docteur/notes.dart';

import 'package:test1/screens/Docteur/EditPatient.dart';
import 'package:test1/screens/PatientOrDoctor.dart';
import 'package:test1/screens/ResetPassword.dart';
import 'package:test1/screens/UpdatePassword.dart';
import 'package:test1/screens/LoginOrSignUp.dart';

import 'package:test1/screens/SignUpDoctor.dart';
import 'package:test1/screens/patient/HomePatient.dart';
import 'package:test1/screens/patient/list/ListOfDoctors.dart';
import 'package:test1/screens/patient/navigator.dart';
import 'package:test1/screens/patient/Form.dart';

import 'package:test1/screens/Docteur/HomeDoctor.dart';

import 'package:test1/screens/Welcome1.dart';
import 'package:test1/screens/LoginPage.dart';
import 'package:test1/screens/SignUpPatient.dart';

import 'home.dart';

import 'screens/patient/PatientAppointments.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'page1',
      home: Welcome1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
