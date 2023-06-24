import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test1/controllers/fetchUsersController.dart';
import 'package:test1/models/GetRDVdOCTEUR.dart';
import 'package:test1/ressources/consts_global.dart';

import '../../controllers/fetchDoctorsController.dart';
import '../../controllers/fetchPatientController.dart';
import 'package:intl/intl.dart';

class DoctorConsultation extends StatefulWidget {
  const DoctorConsultation({super.key});

  @override
  State<DoctorConsultation> createState() => _DoctorConsultationState();
}

class _DoctorConsultationState extends State<DoctorConsultation> {
  List<Chedy>? users;

  FetchDoctorsController fetchDoctorsController =
      Get.put(FetchDoctorsController());
  FetchPatientController fetchpatientController =
      Get.put(FetchPatientController());

  String name = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      List<Chedy> fetchedUsers =
          await fetchDoctorsController.getDoctorappointment();
      setState(() {
        users = fetchedUsers;
        print("Number of elements in users list: ${users!.length}");
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
          DateTime appointmentDate =
              DateTime.parse(users![index].appointmentDate);
          if (appointmentDate.isBefore(DateTime.now())) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
                          style: TextStyle(color: Colors.green)),
                      SizedBox(height: 5.0),
                      Text(
                          'Prescription: ${users![index].prescription ?? "N/A"}'),
                      SizedBox(height: 5.0),
                      Text(
                          'Appointment Date: ${DateFormat('EEEE, d MMMM y - hh:mm a').format(DateTime.parse(users![index].appointmentDate))}'),
                      SizedBox(height: 5.0),
                      Text('Patient ID: ${users![index].patientId}'),
                      // ),
                    ],
                  ),
                  trailing:
                      Icon(Icons.arrow_forward, color: Colors.grey, size: 30.0),
                  onTap: () {
                    // Ajouter ici l'action à effectuer lorsqu'un élément de la liste est sélectionné
                  },
                ),
              ),
            );
          } else {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'BONJOUR',
                      style: TextStyle(fontSize: 20, fontFamily: 'font3'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'You have not seen a patient yet',
                      style: TextStyle(fontSize: 20, fontFamily: 'font3'),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
