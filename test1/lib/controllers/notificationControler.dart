import 'package:get/get.dart';

import '../models/modelePatient.dart';
import 'fetchPatientController.dart';

class NotificationController extends GetxController {
  RxBool comparison = false.obs;
  String appt = "";
  List<Appointment> chedy = [];
  FetchPatientController fetchPatientController =
      Get.put(FetchPatientController());
  Sabri? users;

  todayAppointment() async {
    try {
      var fetchedUsers = await fetchPatientController.getPatient();
      if (users != null) {
        chedy = users!.appointments;
      }
      print(DateTime.now());

      for (int i = 0; i < chedy.length; i++)
        appt = chedy[i].appointmentDate.toString();

      comparison.value = DateTime.now().toString().substring(0, 10) == appt;
      print(comparison.value);
      print(DateTime.now());
      print(chedy[1]);
    } catch (e) {
      print(e);
    }
  }
}
