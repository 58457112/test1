import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/controllers/updateController.dart';

import 'package:test1/ressources/consts_global.dart';
import 'package:test1/models/modele.dart';
import 'package:test1/screens/Welcome1.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:test1/screens/LoginPage.dart';

class EditPatient extends StatefulWidget {
  const EditPatient({super.key});

  @override
  State<EditPatient> createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatient> {
  final userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UpdateController updateController = Get.put(UpdateController());
  late File image;
  final Imagepicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [Text('chedyy')],
      )),
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                'Healthy Steps',
                textAlign: TextAlign.center,
                style: solhealth,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Souhaitez-vous modifier vos informations actuelles ? Remplissez simplement le formulaire ci-dessous pour mettre à jour vos informations personnelles.',
                style: TextStyle(fontFamily: 'font3', fontSize: 17),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/37/2f/67/372f677cf09a8cf376a10a13a236d7a5.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Column(
                  children: [
                    SizedBox(
                      width: 500,
                      child: AnimatedButton(
                        buttonTextStyle: TextStyle(
                          fontFamily: 'font3',
                          color: solcolor2,
                        ),
                        text: 'Email',
                        color: solcolor1,
                        pressEvent: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: 'Changer la sécurité',
                            desc: "Entrez votre nouvel e-mail :",
                            body: Column(
                              children: [
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'New Email',
                                    hintStyle: TextStyle(fontFamily: 'font3'),
                                  ),
                                ),
                              ],
                            ),
                            btnCancelOnPress: () {},
                            btnOkText: 'Changer',
                            btnOkOnPress: () {
                              String newPassword = emailController.text;

                              // Insérez le code pour changer l'e-mail et le mot de passe ici
                            },
                          ).show();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedButton(
                      buttonTextStyle:
                          TextStyle(color: solcolor2, fontFamily: 'font3'),
                      text: 'Change Password',
                      color: solcolor1,
                      pressEvent: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: 'Changer la sécurité',
                          desc:
                              "Entrez votre nouvel e-mail et votre nouveau mot de passe :",
                          body: Column(
                            children: [
                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(fontFamily: 'font3'),
                                ),
                              ),
                            ],
                          ),
                          btnCancelOnPress: () {},
                          btnOkText: 'Changer',
                          btnOkOnPress: () {
                            String newPassword = passwordController.text;
                            // Insérez le code pour changer l'e-mail et le mot de passe ici
                          },
                        ).show();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedButton(
                      buttonTextStyle:
                          TextStyle(color: solcolor2, fontFamily: 'font3'),
                      text: 'About You',
                      color: solcolor1,
                      pressEvent: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: 'Changer les informations',
                          desc: "Entrez vos nouvelles informations :",
                          body: Column(
                            children: [
                              TextField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  hintText: 'New Name',
                                  hintStyle: TextStyle(fontFamily: 'font3'),
                                ),
                              ),
                              TextField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  hintText: 'New Last Name',
                                  hintStyle: TextStyle(fontFamily: 'font3'),
                                ),
                              ),
                              TextField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintText: 'New PhoneNumber',
                                  hintStyle: TextStyle(fontFamily: 'font3'),
                                ),
                              ),
                            ],
                          ),
                          btnCancelOnPress: () {},
                          btnOkText: 'Changer',
                          btnOkOnPress: () {
                            // Insérez le code pour changer les informations ici
                          },
                        ).show();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();
                        Get.to(LoginPage());
                      },
                      child: Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                            color: solcolor1,
                            borderRadius: BorderRadius.circular(60)),
                        child: const Center(
                            child: Text(
                          "LogOut",
                          style:
                              TextStyle(fontFamily: 'font3', color: solcolor2),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        updateController.UpdateUser(
                            emailController.text,
                            firstNameController.text,
                            lastNameController.text,
                            passwordController.text,
                            phoneController.text);
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: solcolor1,
                            borderRadius: BorderRadius.circular(60)),
                        child: const Center(
                            child: Text(
                          "Confirmer",
                          style:
                              TextStyle(fontFamily: 'font3', color: solcolor2),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
