import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/controllers/fetchUsersController.dart';

import '../../../models/modeleDocteurById.dart';
import '../../../ressources/consts_global.dart';

class DoctorName extends StatefulWidget {
  const DoctorName({super.key});

  @override
  State<DoctorName> createState() => _DoctorNameState();
}

class _DoctorNameState extends State<DoctorName> {
  FetchUsersController fetchUsersController = Get.put(FetchUsersController());
  String docName = "";
  String last = "";
  String tel = "";
  String adress = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    try {
      var fetchedDoctor = await fetchUsersController.getDoctorName(data);
      setState(() {
        Docteurr? doc = fetchedDoctor;
        docName = doc!.firstName;
        last = doc.lastName;
        tel = doc.phoneNumber;
        adress = doc.address;
        print("$docName");
      });
    } catch (e) {
      print(e);
    }
  }

  var data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Here is the doctor's information",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'font3',
                  fontWeight: FontWeight.bold,
                  color: solcolor1),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        "First Name",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font3'),
                      ),
                      subtitle: Text(
                        docName,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Last Name",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font3'),
                      ),
                      subtitle: Text(
                        last,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "PhoneNumber",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font3'),
                      ),
                      subtitle: Text(
                        tel,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Adresse",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font3'),
                      ),
                      subtitle: Text(
                        adress,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
