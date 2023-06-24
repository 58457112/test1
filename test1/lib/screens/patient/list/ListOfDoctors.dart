import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/screens/patient/HomePatient.dart';

import 'package:test1/screens/patient/list/search.dart';
import 'package:http/http.dart' as http;

import '../../../controllers/fetchDoctorsController.dart';
import '../../../models/getlistdoc.dart';
import '../../../ressources/consts_global.dart';
import '../../Docteur/Appointments.dart';
import 'package:intl/intl.dart';
import '../../../models/doctor.dart';

class ListOfDoctors extends StatefulWidget {
  const ListOfDoctors({super.key});

  @override
  State<ListOfDoctors> createState() => _HomeState();
}

class _HomeState extends State<ListOfDoctors> {
  Docteur1? users;
  List<Item>? items1;
  Item? ss;
  int specialityId = 1;
  late String availibiliti = 'ONE_WEEK';
  var isLoad = false;
  int size = 0;
  bool? email;
  FetchDoctorsController fetchDoctorsController =
      Get.put(FetchDoctorsController());
  var remoteService = GetDocteurs();
  void _incrementSize() {
    setState(() {
      size++;
    });
    getData();
  }

  void _deincrementSize() {
    setState(() {
      size--;
    });
    getData();
  }

  String name = '';
  String civility = '';
  String first = '';
  String adress = '';
  int id = 0;
  String tel = '';
  String lastname = '';
  int spec = 0;
  List<Availability> availabilities = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _showSpecialityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sélectionner une spécialité'),
          content: DropdownButton<int>(
            value: specialityId,
            onChanged: (newValue) {
              setState(() {
                specialityId = newValue!;
              });
            },
            items: [
              DropdownMenuItem<int>(
                value: 0,
                child: Text('Toutes les spécialités'),
              ),
              DropdownMenuItem<int>(
                value: 1,
                child: Text('Médecin généraliste'),
              ),
              DropdownMenuItem<int>(
                value: 51,
                child: Text('Orthopédiste'),
              ),
              DropdownMenuItem<int>(
                value: 101,
                child: Text('Ophtalmologue'),
              ),
              DropdownMenuItem<int>(
                value: 151,
                child: Text('Pédiatre'),
              ),
              DropdownMenuItem<int>(
                value: 201,
                child: Text('Dentiste'),
              ),
              // Ajoutez d'autres spécialités ici
            ],
          ),
          actions: [
            TextButton(
              child: Text('Filtrer'),
              onPressed: () {
                Navigator.of(context).pop();
                getData(); // Méthode pour exécuter la recherche de médecins avec le filtre
              },
            ),
          ],
        );
      },
    );
  }

  void _showAvailabilityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sélectionner une disponibilité'),
          content: DropdownButton<String>(
            value: availibiliti,
            onChanged: (newValue) {
              setState(() {
                availibiliti = newValue!;
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: 'TODAY',
                child: Text('Aujourd\'hui'),
              ),
              DropdownMenuItem<String>(
                value: 'THREE_DAYS',
                child: Text('Dans trois jours'),
              ),
              DropdownMenuItem<String>(
                value: 'ONE_WEEK',
                child: Text('Dans une semaine'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Filtrer'),
              onPressed: () {
                Navigator.of(context).pop();
                getData(); // Méthode pour exécuter la recherche de médecins avec le filtre
              },
            ),
          ],
        );
      },
    );
  }

  getData() async {
    try {
      var remoteService = GetDocteurs();
      remoteService.pageSize++;
      var fetchedUsers = await fetchDoctorsController.getDoctors(
          size, specialityId, availibiliti);
      setState(() {
        users = fetchedUsers;
        items1 = fetchedUsers?.items;
        ss = items1![0];
        name = ss!.lastName;
        lastname = ss!.firstName;

        email = users!.first;
        isLoad = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.93),
        appBar: _appBar(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items1?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  var item = items1 != null ? items1![index] : null;
                  return item != null
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Appointments(
                                  availabilities: List<Availability>.from(
                                      item.availabilities),
                                  id: item.id,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Color.fromARGB(255, 181, 216, 245),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.civility +
                                        ' ' +
                                        item.firstName +
                                        ' ' +
                                        item.lastName,
                                    style: TextStyle(
                                      fontFamily: 'font3',
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    item.email,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Spécialité: ' +
                                        (item.specialityId == 1
                                            ? 'Médecin généraliste'
                                            : item.specialityId == 101
                                                ? 'Ophtalmologue'
                                                : item.specialityId == 51
                                                    ? 'Orthopédiste'
                                                    : item.specialityId == 151
                                                        ? 'Pédiatre'
                                                        : item.specialityId ==
                                                                201
                                                            ? 'Dentiste'
                                                            : 'Inconnu'),
                                    style: TextStyle(
                                      fontFamily: 'font3',
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Availabilities:',
                                    style: TextStyle(
                                        fontFamily: 'font3',
                                        fontSize: 18,
                                        color: Colors.green),
                                  ),
                                  SizedBox(height: 8),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: item.availabilities.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final availability =
                                          item.availabilities[index];
                                      var startDate = availability.startDate;
                                      final endDate = availability.endDate;
                                      var now = DateTime.now();

                                      if (endDate.isBefore(now) ||
                                          (startDate.isBefore(now) &&
                                              !endDate.isAfter(now))) {
                                        return Container();
                                      } else if (startDate.isBefore(now)) {
                                        startDate = now;
                                      }

                                      final formattedStartDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(startDate);
                                      final formattedEndDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(endDate);
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '- From:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(formattedStartDate),
                                            SizedBox(width: 16),
                                            Text(
                                              '- To:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(formattedEndDate),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _deincrementSize();
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: solcolor1,
                          borderRadius: BorderRadius.circular(60)),
                      child: const Center(
                          child: Text(
                        "Previous",
                        style: TextStyle(fontFamily: 'font2'),
                      )),
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      _incrementSize();
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: solcolor1,
                          borderRadius: BorderRadius.circular(60)),
                      child: const Center(
                          child: Text(
                        "Next",
                        style: TextStyle(fontFamily: 'font2'),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.95),
      title: Text(
        'List of doctors',
        style: TextStyle(fontFamily: 'font1', color: Colors.black),
        textAlign: TextAlign.center,
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: solcolor1),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      leading: IconButton(
        icon: Icon(Icons.assignment),
        onPressed: () {
          _showAvailabilityDialog();
          // Get.to(HomePatient());
        },
      ),
      actions: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  _showSpecialityDialog();
                },
                icon: Icon(Icons.person_add_alt)),
            SizedBox(
              width: 8,
            ),
          ],
        )
      ],
    );
  }
}

class GetDocteurs {
  int pageSize = 0;
  void incrementPageSize() {
    pageSize++;
  }
}
