import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test1/models/facture%20modele.dart';
import '../../../ressources/consts_global.dart';
import '../../controllers/fetchDoctorsController.dart';

class Facture extends StatefulWidget {
  const Facture({super.key});

  @override
  State<Facture> createState() => _FactureState();
}

class _FactureState extends State<Facture> {
  List<FactureModel>? users;
  FetchDoctorsController fetchDoctorsController =
      Get.put(FetchDoctorsController());
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      List<FactureModel> fetchedUsers =
          await fetchDoctorsController.getDoctorFacture();

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
        backgroundColor: Colors.white.withOpacity(0.93),
        appBar: _appBar(),
        body: ListView.builder(
          itemCount: users != null ? users!.length : 0,
          itemBuilder: (BuildContext context, int index) {
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
                              right:
                                  BorderSide(width: 1.0, color: Colors.grey))),
                      child: Icon(Icons.fact_check, color: Colors.grey),
                    ),
                    title: Text(
                      ' ID: ${users![index].id}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        Text('Status: ${users![index].status}',
                            style: TextStyle(color: Colors.green)),
                        SizedBox(height: 5.0),
                        Text('appointmentFee: ${users![index].appointmentFee}'),
                        SizedBox(height: 5.0),

                        // ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward,
                        color: Colors.grey, size: 30.0),
                    onTap: () {
                      // Ajouter ici l'action à effectuer lorsqu'un élément de la liste est sélectionné
                    },
                  ),
                ),
              ),
            );
          },
        ));
  }
}

AppBar _appBar() {
  return AppBar(
    backgroundColor: Colors.white.withOpacity(0.95),
    title: Text(
      'Factures',
      style: TextStyle(fontFamily: 'font1', color: Colors.black),
      textAlign: TextAlign.center,
    ),
    elevation: 0,
    iconTheme: IconThemeData(color: solcolor1),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {},
    ),
    actions: [
      // IconButton(
      //     onPressed: () {
      //       // Navigator.push(context,
      //       //     MaterialPageRoute(builder: (context) => const SearchPage()));
      //     },
      //     icon: Icon(Icons.search))
    ],
  );
}
