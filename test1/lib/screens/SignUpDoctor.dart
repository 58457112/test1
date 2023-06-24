// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/controllers/authController.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:http/http.dart' as http;

import '../models/Getspecialite.dart';
import '../models/model_user.dart';
import '../models/model_user1.dart';
import 'LoginOrSignUp.dart';

class SignUpDoctor extends StatefulWidget {
  const SignUpDoctor({super.key});

  @override
  State<SignUpDoctor> createState() => _SignUpDoctorState();
}

class _SignUpDoctorState extends State<SignUpDoctor> {
  Spec? selectedSpec;

  List<Spec>? specList;
  var isLoad = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var remoteService = RemoteService();
      var fetchedSpecList = await remoteService.getUsers();
      setState(() {
        specList = fetchedSpecList;
        isLoad = true;
      });
    } catch (e) {
      print(e);
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController civilController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController spectController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController ribController = TextEditingController();
  String? _error;
  String? _selectedRole;
  String? _selectedCivil;
  AuthController authController = Get.put(AuthController());

  String? errorMessage;

  final _formfield = GlobalKey<FormState>();

  String? chedy;
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
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter adresse";
                                }
                                bool emailvalid =
                                    RegExp(r'^[A-Za-z][A-Za-z0-9_]')
                                        .hasMatch(value);

                                if (!emailvalid) {
                                  return "enter valid adresse";
                                }
                              },
                              controller: adressController,
                              cursorColor: solcolor1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Adresse',
                                labelStyle: TextStyle(
                                    color: Colors.grey, fontFamily: 'font3'),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                prefixIcon: const Icon(
                                  Icons.account_box,
                                  color: solcolor1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                    Text("Civility:",
                                        style: TextStyle(
                                            fontFamily: 'font3', fontSize: 16)),
                                  ],
                                ),
                                SizedBox(height: 10),
                                DropdownButtonFormField<String>(
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
                                        style: TextStyle(fontFamily: 'font3'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "MRS",
                                      child: Text("MRS",
                                          style:
                                              TextStyle(fontFamily: 'font3')),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "MS",
                                      child: Text("MS",
                                          style:
                                              TextStyle(fontFamily: 'font3')),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 30.0,
                                      vertical: 10.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  dropdownColor: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 200,
                                  child: Container(
                                    child: Expanded(
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                          labelText: 'specialties',
                                          labelStyle: TextStyle(
                                              fontFamily: 'font3',
                                              fontSize: 25),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                        child: ListView.builder(
                                          itemCount: specList?.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                // Traitement à effectuer lorsqu'un élément est sélectionné
                                                int selectedSpecId =
                                                    specList![index].id;
                                                print(
                                                    'ID de l\'élément sélectionné: $selectedSpecId');
                                                String selectedSpecName =
                                                    specList![index].name;
                                                setState(() {
                                                  chedy = selectedSpecName;
                                                  spectController.text =
                                                      selectedSpecId
                                                          .toString(); // mettre à jour la valeur sélectionnée
                                                });
                                                print(selectedSpecName);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  specList?[index].name ?? '',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'font3',
                                                      color: Colors.white),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'the chosen specialty is: $chedy',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'font3',
                                    fontSize:
                                        20, // modifier la taille de la police en fonction de vos besoins
                                    fontWeight: FontWeight
                                        .bold, // ajouter une épaisseur à la police
                                    color: Colors
                                        .white, // changer la couleur de la police en fonction de votre arrière-plan
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter rib";
                                }
                                bool emailvalid =
                                    RegExp(r'^[A-Za-z][A-Za-z0-9_]')
                                        .hasMatch(value);

                                if (!emailvalid) {
                                  return "enter rib";
                                }
                              },
                              controller: ribController,
                              cursorColor: solcolor1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Rib',
                                labelStyle: TextStyle(
                                    color: Colors.grey, fontFamily: 'font3'),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                prefixIcon: const Icon(
                                  Icons.account_box,
                                  color: solcolor1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          InkWell(
                            onTap: () {
                              if (_formfield.currentState!.validate()) {
                                //addUser();
                                //signUp();
                                authController.registreDoc(
                                  emailController.text,
                                  passwordController.text,
                                  firstnameController.text,
                                  lastController.text,
                                  civilController.text,
                                  phoneController.text,
                                  ribController.text,
                                  int.parse(spectController.text),
                                  adressController.text,
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RemoteService {
  // Future<String> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token') ?? '';
  //   return token;
  // }
  Future<List<Spec>> getUsers() async {
    var client = http.Client();
    var uri = Uri.parse(
        "http://clinic-management-service.eu-west-3.elasticbeanstalk.com/clinic-management-service/api/v1/specialities");
    var response = await client.get(
      uri,
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjaGVkeTEyQGdtYWlsLmNvbSIsImV4cCI6MTY4MjM0NDQ5MCwiaWF0IjoxNjgyMzI2NDkwfQ.hkUCV-B7cLnRTc3VgqacI179xqSvBvNPhlNS9v8eZrMb3EmqDiHRbq-6ssKVmtu1taTml0fwk8eJdiwHwD2lfw"
      },
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var json1 = utf8.decode(response.bodyBytes);

      var specList = Spec.specListFromJson(json.decode(json1));
      return specList;
    } else {
      throw Exception("Failed to get users");
    }
  }
}
