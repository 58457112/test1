import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:test1/controllers/fetchPatientController.dart';
import 'package:test1/ressources/consts_global.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../models/modelePatient.dart';
import '../../notif.dart';
import 'list/DoctorName.dart';
import 'package:test1/controllers/notificationControler.dart';

class PatientAppointments extends StatefulWidget {
  const PatientAppointments({super.key});

  @override
  State<PatientAppointments> createState() => _PatientAppointmentsState();
}

class _PatientAppointmentsState extends State<PatientAppointments> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<String> statusList = ['Pending', 'Done']; // Liste des choix pour status
  String selectedStatus = 'Pending'; // Statut initial
  Sabri? users;
  var isLoad = false;
  String? email;
  List<Appointment> chedy = [];
  FetchPatientController fetchPatientController =
      Get.put(FetchPatientController());

  NotificationController notificationController =
      Get.put(NotificationController());
  String name = "";
  bool comparison = false;
  String appt = "";
  @override
  void initState() {
    super.initState();
    getData();
    print(todayAppointment());
    notificationController.todayAppointment();

    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  todayAppointment() async {
    try {
      var fetchedUsers = await fetchPatientController.getPatient();
      setState(() {
        for (int i = 0; i < chedy.length; i++)
          appt = chedy[i].appointmentDate.toString();
        print(DateTime.now().toString().substring(0, 10));
        print(appt.substring(0, 10));
        //print(DateTime.now().toString().substring(0, 10) == appt);
        comparison =
            DateTime.now().toString().substring(0, 10) == appt.substring(0, 10);
      });
      if (comparison == true) {
        return true;
      } else
        return false;
    } catch (e) {
      print(e);
    }
  }

  getData() async {
    try {
      var fetchedUsers = await fetchPatientController.getPatient();
      setState(() {
        users = fetchedUsers;
        chedy = users!.appointments;
        email = users!.phoneNumber;
        isLoad = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Bonjourr ',
              style: TextStyle(
                  fontSize: 25, fontFamily: 'font3', color: solcolor1),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Voila Toutes les rendez-vous',
                style: TextStyle(fontSize: 20, fontFamily: 'font3')),
            Expanded(
              child: ListView.builder(
                itemCount: chedy.length,
                itemBuilder: (BuildContext context, int index) {
                  Appointment rendezvous = chedy[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DoctorName(),
                          arguments: rendezvous.doctorId);
                    },
                    child: Card(
                      color: Color.fromARGB(255, 181, 218, 248),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rendez-vous ${index + 1}:',
                              style:
                                  TextStyle(fontSize: 16, fontFamily: 'font3'),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Status: ${rendezvous.status}',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'font3'),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'La Date du Rendez-vous : ${DateFormat('EEEE, d MMMM y - hh:mm a').format(DateTime.parse(rendezvous.appointmentDate.toString()))}',
                              style: TextStyle(
                                fontSize: 14,
                                color: solcolor1,
                                fontFamily: 'font3',
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                color: solcolor1,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String reason = '';

                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        title: Text('Annuler'),
                                        content: TextField(
                                          onChanged: (value) {
                                            reason = value;
                                          },
                                          decoration: InputDecoration(
                                            hintText:
                                                'Entrez la raison d\'annulation',
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('Annuler'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Text('Valider'),
                                            onPressed: () {
                                              fetchPatientController.Cancell(
                                                rendezvous.doctorId,
                                                rendezvous.id,
                                                reason,
                                              );
                                              print(
                                                  'Raison d\'annulation : $reason');
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "Cancell",
                                    style: TextStyle(
                                      fontFamily: 'font2',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
