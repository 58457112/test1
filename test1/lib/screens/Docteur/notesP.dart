import '../../../ressources/consts_global.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'newpageNote.dart';

class NotesP extends StatefulWidget {
  const NotesP({super.key});

  @override
  State<NotesP> createState() => _NotesPState();
}

class _NotesPState extends State<NotesP> {
  List<Widget> _noteWidgets = [];
  final _random = Random();

  void _addNote() {
    Color randomColor = Color.fromRGBO(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      1,
    );

    setState(() {
      _noteWidgets.add(
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPage(color: randomColor),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: randomColor,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _noteWidgets.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: _noteWidgets[index],
              );
            },
          ),
          Positioned(
            bottom: 16,
            right: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.greenAccent,
              onPressed: () {
                _addNote();
                print(_noteWidgets.length);
              },
              child: Icon(
                Icons.note_alt_sharp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
