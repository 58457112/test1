import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:test1/controllers/appointmentController.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:http/http.dart' as http;

import '../../models/doctor.dart';

class Appointments extends StatefulWidget {
  final List<Availability> availabilities;

  final int id;
  const Appointments({Key? key, required this.id, required this.availabilities})
      : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  String _selectedDateText = '';
  String _selectedTimeText = '';
  // var chedy = RemoteService();

  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  TextEditingController eventController = TextEditingController();
  TextEditingController heure = TextEditingController();

  // Get controller injection : *
  MyclassController myclassController = Get.put(MyclassController());

  void sendRequest() {}

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    eventController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _timeController = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(
            "Choisir l'heure de rendez-vous",
            style: TextStyle(fontFamily: 'font3', color: Colors.blueAccent),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Heure',
                  hintText: 'hh:mm',
                ),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop(_timeController.text);

                // myclassController.registre(_selectedDay, widget.id);
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(60)),
                child: const Center(
                    child: Text(
                  "Confirmer ",
                  style: TextStyle(fontFamily: 'font3', color: Colors.white),
                )),
              ),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        // Traiter la valeur saisie dans le champ de texte
        myclassController.addAppointment(_selectedDay, widget.id, value);
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = [
      'Téléconsultation',
      'Consultation physique',
    ];

    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                child: TableCalendar(
                  calendarFormat: _calendarFormat,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: _onDaySelected,
                  headerStyle: HeaderStyle(
                    titleTextStyle:
                        TextStyle(fontSize: 18, fontFamily: 'font1'),
                    formatButtonVisible: false,
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    holidayTextStyle: TextStyle(color: solcolor1),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(fontFamily: 'font3'),
                    weekendStyle:
                        TextStyle(fontFamily: 'font3', color: solcolor1),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 28, 46, 78),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular((50)),
                      topRight: Radius.circular(50)),
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Voici les disponibilités de votre médecin :',
                        style: TextStyle(
                            fontFamily: 'font3',
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: ListView.builder(
                          itemCount: widget.availabilities.length,
                          itemBuilder: (BuildContext context, int index) {
                            final availability = widget.availabilities[index];
                            var startDate = availability.startDate;
                            final endDate = availability.endDate;
                            final formattedStartDate =
                                DateFormat('dd/MM/yyyy').format(startDate);
                            final formattedEndDate =
                                DateFormat('dd/MM/yyyy').format(endDate);
                            var now = DateTime.now();

                            if (endDate.isBefore(now) ||
                                (startDate.isBefore(now) &&
                                    !endDate.isAfter(now))) {
                              return Container();
                            } else if (startDate.isBefore(now)) {
                              startDate = now;
                            }
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '- From:',
                                    style: TextStyle(
                                      fontFamily: 'font3',
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    formattedStartDate,
                                    style: TextStyle(
                                        fontFamily: 'font3',
                                        fontSize: 16,
                                        color: Colors.green),
                                  ),
                                  SizedBox(width: 16.0),
                                  Text(
                                    '- To:',
                                    style: TextStyle(
                                        fontFamily: 'font3',
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(formattedEndDate,
                                      style: TextStyle(
                                          fontFamily: 'font3',
                                          fontSize: 16,
                                          color: Colors.green)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: InkWell(
                          onTap: () {
                            _showDialog();

                            // myclassController.registre(_selectedDay, widget.id);
                          },
                          child: Container(
                            height: 50,
                            width: 210,
                            decoration: BoxDecoration(
                                color: solcolor1,
                                borderRadius: BorderRadius.circular(60)),
                            child: const Center(
                                child: Text(
                              "Selectionne une heure a ce date  ",
                              style: TextStyle(
                                  fontFamily: 'font3', color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
