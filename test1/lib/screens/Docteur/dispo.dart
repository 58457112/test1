import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test1/controllers/availibilitiesController.dart';
import 'package:test1/ressources/consts_global.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Dispo extends StatefulWidget {
  const Dispo({super.key});

  @override
  State<Dispo> createState() => _DispoState();
}

class _DispoState extends State<Dispo> {
  DateTimeRange daterange =
      DateTimeRange(start: DateTime(2023, 4, 11), end: DateTime(2023, 4, 15));
  // late Map<DateTime, List<Event>> selectedEvent;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime startDate;
  late DateTime endDate;
  TextEditingController stardate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  AvailibilityController availibilityController =
      Get.put(AvailibilityController());

  @override
  Widget build(BuildContext context) {
    final start = daterange.start;
    final end = daterange.end;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: ListView(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Hello Doctor  ',
                  style: TextStyle(
                      fontSize: 24, color: solcolor1, fontFamily: 'font1'),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Bonjour Docteur, pourriez-vous s'il vous plaît prendre quelques instants pour remplir votre période de travail ",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontFamily: 'font3'),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/55/68/11/5568115830c16c72ef821cdca43d11fd.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300.0,
                  child: TextFormField(
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "enter adresse";
                    //   }
                    //   bool emailvalid =
                    //       RegExp(r'^[A-Za-z][A-Za-z0-9_]').hasMatch(value);

                    //   if (!emailvalid) {
                    //     return "Enter valid adresse";
                    //   }
                    // },
                    controller: stardate,
                    cursorColor: solcolor1,
                    decoration: InputDecoration(
                      hintText: "2022-2-yy",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'StartDate',
                      labelStyle:
                          TextStyle(color: Colors.grey, fontFamily: 'font3'),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30.0),
                      prefixIcon: const Icon(
                        Icons.date_range_outlined,
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
                  child: TextFormField(
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "enter adresse";
                    //   }
                    //   bool emailvalid =
                    //       RegExp(r'^[A-Za-z][A-Za-z0-9_]').hasMatch(value);

                    //   if (!emailvalid) {
                    //     return "Enter valid adresse";
                    //   }
                    // },
                    controller: enddate,
                    cursorColor: solcolor1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'EndDate',
                      labelStyle:
                          TextStyle(color: Colors.grey, fontFamily: 'font3'),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30.0),
                      prefixIcon: const Icon(
                        Icons.date_range_outlined,
                        color: solcolor1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    await availibilityController.createAvailability(
                        stardate.text, enddate.text);
                  },
                  child: Container(
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                        color: solcolor1,
                        borderRadius: BorderRadius.circular(60)),
                    child: const Center(
                        child: Text(
                      "Confirmer",
                      style: TextStyle(fontFamily: 'font3'),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

//   Future pickDateRange() async {
//     DateTimeRange? newDteRange = await showDateRangePicker(
//         context: context,
//         initialDateRange: daterange,
//         firstDate: DateTime(1900),
//         lastDate: DateTime(2100));
//     builder:
//     (BuildContext context, Widget? child) {
//       return Theme(
//         data: ThemeData.light().copyWith(
//           primaryColor:
//               Colors.green, // changer la couleur de l'icône de la date
//           accentColor: Colors
//               .blue, // changer la couleur du fond de l'ensemble du calendrier
//           colorScheme: ColorScheme.light(primary: Colors.blue),
//           buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
//         ),
//         child: child!,
//       );
//     };

//     if (newDteRange == null) return;
//     setState(() => daterange = newDteRange);
//   }

//   DateTimeRange? selectedDateRange;

//   void sendRendezVousToApi(DateTimeRange dateRange) async {
//     var url = Uri.parse(
//         'https://63f3d63afe3b595e2ee9fc78.mockapi.io/day/rendez-vous');
//     var response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'start_date': DateFormat('dd/MM/yyyy').format(dateRange.start),
//         'end_date': DateFormat('dd/MM/yyyy').format(dateRange.end),
//       }),
//     );
//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');

//     // Traitement de la réponse JSON
//     var jsonResponse = json.decode(response.body);
//     var id = jsonResponse['id'];
//     var start = jsonResponse['start_date'];
//     var end = jsonResponse['end_date'];
//     print('ID: $id');
//     print('Start: $start');
//     print('End: $end');
//   }
// }
}
