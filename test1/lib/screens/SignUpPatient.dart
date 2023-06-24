// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test1/controllers/authController.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:http/http.dart' as http;

import '../models/model_user.dart';
import 'LoginOrSignUp.dart';

class SignUpPatient extends StatefulWidget {
  const SignUpPatient({super.key});

  @override
  State<SignUpPatient> createState() => _SignUpPatientState();
}

class _SignUpPatientState extends State<SignUpPatient> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController civilController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  String? _error;
  String? _selectedRole;
  String? _selectedCivil;

  String? errorMessage;

  final _formfield = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var selectedCivility;
    return Scaffold(
        backgroundColor: solcolor1,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Form(
                key: _formfield,
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'Healthy Steps',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'font1',
                                fontSize: 40,
                                color: solcolor3),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Create a new account',
                            style: TextStyle(
                                fontFamily: "font3",
                                fontSize: 23,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Please fill in the form to continue',
                            style: TextStyle(
                                fontFamily: "font3",
                                fontSize: 14,
                                color: Color.fromARGB(255, 235, 229, 229)),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter user";
                                }
                                bool emailvalid =
                                    RegExp(r'^[A-Za-z][A-Za-z0-9_]')
                                        .hasMatch(value);

                                if (!emailvalid) {
                                  return "Enter valid Firstname";
                                }
                              },
                              controller: firstnameController,
                              cursorColor: solcolor1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Firstname',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontFamily: 'font3'),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  prefixIcon: const Icon(
                                    Icons.account_box,
                                    color: solcolor1,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        firstnameController.clear();
                                      },
                                      icon: const Icon(Icons.clear))),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter user";
                                }
                                bool emailvalid =
                                    RegExp(r'^[A-Za-z][A-Za-z0-9_]')
                                        .hasMatch(value);

                                if (!emailvalid) {
                                  return "enter valid lastname";
                                }
                              },
                              controller: lastController,
                              cursorColor: solcolor1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Lastname',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontFamily: 'font3'),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  prefixIcon: const Icon(
                                    Icons.account_box,
                                    color: solcolor1,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        lastController.clear();
                                      },
                                      icon: const Icon(Icons.clear))),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter email";
                                }
                                bool emailvalid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value);
                                if (!emailvalid) {
                                  return "verif email !";
                                }
                                if (errorMessage != null)
                                  Text(
                                    errorMessage!,
                                    style: TextStyle(color: Colors.red),
                                  );
                              },
                              controller: emailController,
                              cursorColor: solcolor1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: ' Email',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontFamily: 'font3'),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 30.0),
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: solcolor1,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter Password";
                                }
                                bool emailvalid = RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value);
                                if (!emailvalid) {
                                  return "the password must start with an uppercase letter \n and a lowercase letter, at least 8 digits and a special character";
                                }
                              },
                              controller: passwordController,
                              cursorColor: solcolor1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: ' Password',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontFamily: 'font3'),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 30.0),
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: solcolor1,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter Your Number";
                                }
                                bool emailvalid =
                                    RegExp(r'^(?:[+0]9)?[0-9]{8}$')
                                        .hasMatch(value);
                                if (!emailvalid) {
                                  return "enter valid Number";
                                }
                              },
                              controller: phoneController,
                              cursorColor: solcolor1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: ' Number',
                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontFamily: 'font3'),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 30.0),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: solcolor1,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Civilité:",
                                        style: TextStyle(
                                            fontFamily: 'font3', fontSize: 16)),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30),
                                    border:
                                        Border.all(color: Colors.grey[400]!),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedCivil,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCivil = value;
                                        civilController.text = _selectedCivil!;
                                      });
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "MR",
                                        child: Text(
                                          "MR",
                                          style: TextStyle(
                                              fontFamily: 'font3',
                                              fontSize: 16),
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "MRS",
                                        child: Text(
                                          "MRS",
                                          style: TextStyle(
                                              fontFamily: 'font3',
                                              fontSize: 16),
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "MS",
                                        child: Text(
                                          "MS",
                                          style: TextStyle(
                                              fontFamily: 'font3',
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    dropdownColor: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          InkWell(
                            onTap: () {
                              if (_formfield.currentState!.validate()) {
                                //addUser();
                                //signUp();
                                authController.registrePatient(
                                  emailController.text,
                                  passwordController.text,
                                  firstnameController.text,
                                  lastController.text,
                                  civilController.text,
                                  phoneController.text,
                                );
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 90, 90, 228),
                                  borderRadius: BorderRadius.circular(60)),
                              child: const Center(
                                  child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'font3'),
                              )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
