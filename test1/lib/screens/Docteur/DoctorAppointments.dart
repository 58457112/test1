import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test1/controllers/fetchUsersController.dart';
import 'package:test1/models/GetRDVdOCTEUR.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:test1/screens/Docteur/name.dart';

import '../../controllers/fetchDoctorsController.dart';
import '../../controllers/fetchPatientController.dart';
import 'package:intl/intl.dart';

import '../../models/modelePatient.dart';

class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({super.key});

  @override
  State<DoctorAppointments> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  List<Chedy>? users;
  Sabri? patient;

  FetchDoctorsController fetchDoctorsController =
      Get.put(FetchDoctorsController());
  FetchPatientController fetchpatientController =
      Get.put(FetchPatientController());
  final TextEditingController Prescriptions = TextEditingController();

  String name = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<String> patientNamesList = [];

  getData() async {
    try {
      List<Chedy> fetchedUsers =
          await fetchDoctorsController.getDoctorappointment();

      setState(() {
        users = fetchedUsers;

        print("Number of elements in users list: ${users!.length}");
      });
      List<String> patientNames = [];
      for (int i = 0; i < users!.length; i++) {
        int patientId = users![i].patientId;
        print(patientId);
        Sabri? patient =
            await fetchpatientController.getPatientFirstname(patientId);
        // Utilisez les informations du patient dans votre code
        String patientName = patient?.lastName ?? "N/A";
        print("Patient Name: $patientName");
      }
      setState(() {
        // Mettre à jour la liste des noms des patients dans l'état
        patientNamesList = patientNames;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: ListView.builder(
        itemCount: users != null ? users!.length : 0,
        itemBuilder: (BuildContext context, int index) {
          String patientName = patient?.lastName ?? "N/A";
          DateTime appointmentDate =
              DateTime.parse(users![index].appointmentDate);
          // if (appointmentDate.isAfter(DateTime.now())) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1.0, color: Colors.grey))),
                    child: Icon(Icons.medical_services, color: Colors.grey),
                  ),
                  title: Text(
                    'Appointment ID: ${users![index].id}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Text('Status: ${users![index].status}',
                          style: TextStyle(
                              color: Colors.green, fontFamily: 'font3')),
                      SizedBox(height: 5.0),
                      Text(
                          'Prescription: ${users![index].prescription ?? "N/A"}',
                          style: TextStyle(fontFamily: 'font3')),
                      SizedBox(height: 5.0),
                      Text(
                        'Appointment Date: ${DateFormat('EEEE, d MMMM y - hh:mm a').format(DateTime.parse(users![index].appointmentDate))}',
                        style: TextStyle(fontFamily: 'font3'),
                      ),
                      SizedBox(height: 5.0),
                      Row(children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => NamePage(),
                                arguments: users![index].patientId);
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: solcolor1,
                                borderRadius: BorderRadius.circular(60)),
                            child: const Center(
                                child: Text(
                              "View Patient",
                              style: TextStyle(fontFamily: 'font2'),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            fetchDoctorsController.Done(
                              users![index].id,
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                color: solcolor1,
                                borderRadius: BorderRadius.circular(60)),
                            child: const Center(
                                child: Text(
                              "Approuve",
                              style: TextStyle(fontFamily: 'font2'),
                            )),
                          ),
                        )
                      ])

                      // ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward,
                        color: Colors.grey, size: 30.0),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController prescriptionController =
                              TextEditingController();
                          return AlertDialog(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 60.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  "Prescription",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                TextField(
                                  controller: prescriptionController,
                                  decoration: InputDecoration(
                                    hintText: "Entrez votre prescription",
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  // Faites quelque chose avec la prescription
                                  String prescription =
                                      prescriptionController.text;
                                  // Fermez la boîte de dialogue
                                  Navigator.of(context).pop();
                                },
                                child: Text("Save"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          );
          // } else {
          //   // Si la date du rendez-vous est dans le passé, ne rien afficher
          //   return Container(); // Ou retournez un Widget vide selon vos besoins
          // }
        },
      ),
    );
  }
}
