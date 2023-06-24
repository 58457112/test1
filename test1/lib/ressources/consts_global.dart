import 'package:flutter/material.dart';

const solGetstarted = AssetImage('assets/Getstarted.png');
const solwelcome = AssetImage('assets/welcome.png');
const sollogin = AssetImage('assets/login.png');
const solhealth =
    TextStyle(fontFamily: 'font1', fontSize: 40.0, color: solcolor1);

const solmakeit = TextStyle(
  fontFamily: 'font1',
  fontSize: 30.0,
);

const solTextfield1 = TextField(
  cursorColor: solcolor1,
  decoration: InputDecoration(
      labelText: 'entrer amail',
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
      prefixIcon: Icon(Icons.mail)),
);

const solTexfield2 = TextField(
  cursorColor: solcolor1,
  decoration: InputDecoration(
      labelText: 'Password',
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
      prefixIcon: Icon(Icons.lock_outline)),
  obscureText: true,
);
const solcolor4 = Color(0xff82c3ec);
const solcolor1 = Color(0xff9997cc);
const solcolor2 = Color.fromRGBO(209, 255, 243, 1);
const solcolor3 = Color(0xff3F3D56);
final b1 = ElevatedButton.styleFrom(
  backgroundColor: solcolor2,
  fixedSize: const Size.fromWidth(300.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  padding: const EdgeInsets.all(20), //content padding inside button
);
final b2 = ElevatedButton.styleFrom(
  backgroundColor: Color.fromARGB(255, 64, 151, 205),
  fixedSize: const Size.fromWidth(300.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  padding: const EdgeInsets.all(20), //content padding inside button
);
