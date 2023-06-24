import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/controllers/authController.dart';

import 'package:test1/home.dart';
import 'package:test1/models/model_authlogin.dart';
import 'package:test1/models/model_user.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:test1/screens/Docteur/dispo.dart';
import 'package:test1/screens/Docteur/navibar.dart';
import 'package:test1/screens/ResetPassword.dart';
import 'package:test1/models/modelePatient.dart';

import 'package:test1/screens/patient/navigator.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Sabri? users;
  var isLoad = false;
  String? email;
  String? role;
  String? civilite;
  String name = "";
  AuthController authController = Get.put(AuthController());

  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final _formfield = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names

  bool isChecked = false;
  bool passTogle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: solcolor1,
      body: Form(
        key: _formfield,
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 0,
                  ),
                  const SizedBox(
                      width: 300.0,
                      height: 330.0,
                      child: Image(image: sollogin)),
                  SizedBox(
                    width: 300.0,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter Email";
                        }
                        bool emailvalid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailvalid) {
                          return "enter email";
                        }
                      },
                      controller: emailcontroller,
                      cursorColor: solcolor2,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontFamily: 'font3'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                        prefixIcon: Icon(Icons.mail),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        controller: passcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter Password";
                          }
                          bool emailvalid = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value);
                          if (!emailvalid) {
                            return "enter Password valid";
                          }
                        },
                        cursorColor: solcolor2,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontFamily: 'font3'),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30.0),
                          prefixIcon: Icon(Icons.lock_outline),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passTogle = !passTogle;
                              });
                            },
                            child: Icon(passTogle
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        obscureText: passTogle,
                      )),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          if (_formfield.currentState!.validate()) {
                            authController.Authentification(
                                emailcontroller.text, passcontroller.text);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              color: solcolor2,
                              borderRadius: BorderRadius.circular(60)),
                          child: const Center(
                              child: Text(
                            "login",
                            style: TextStyle(fontFamily: 'font2'),
                          )),
                        ),
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()),
                      );
                    },
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontFamily: 'font3',
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
