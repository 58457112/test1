import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  final Color color;

  const NewPage({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(children: [
          ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Notes',
                  style: TextStyle(fontFamily: 'font3', fontSize: 31),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Titre du note',
                      hintStyle: TextStyle(fontFamily: 'font3'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Contenu du note',
                      hintStyle: TextStyle(fontFamily: 'font3'),
                      contentPadding:
                          const EdgeInsets.only(top: 20, bottom: 100, left: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: color),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Consignes et médicaments',
                      hintStyle: TextStyle(fontFamily: 'font3'),
                      contentPadding:
                          const EdgeInsets.only(top: 20, bottom: 100, left: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  child: FloatingActionButton(
                    backgroundColor: color,
                    onPressed: () {},
                    child: Icon(
                      Icons.save_alt_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ]),
      ),
    );
  }
}
