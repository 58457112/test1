import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test1/screens/Docteur/notesP.dart';
import '../../../ressources/consts_global.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.93),
      body: Column(
        children: [
          SizedBox(
            height: h * 0.5,
            // child: Image.asset(
            //   'assets/notes.png',
            // ),
            child: CircleAvatar(
              radius: 130,
              backgroundImage: AssetImage('assets/notes.png'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Daily Notes',
            style: TextStyle(
                fontFamily: 'font1', color: Colors.black, fontSize: 23),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 54),
            child: Text(
              'Take notes,reminders,set targets,collect ressources ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontFamily: 'font3'),
            ),
          ),
          SizedBox(
            height: h * 0.1,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotesP()),
              );
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: solcolor1, borderRadius: BorderRadius.circular(60)),
              child: const Center(
                  child: Text(
                "Get started",
                style: TextStyle(fontFamily: 'font3'),
              )),
            ),
          )
        ],
      ),
    );
  }
}
