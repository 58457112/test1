import 'package:flutter/material.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:test1/screens/LoginPage.dart';
import 'package:test1/screens/SignUpPatient.dart';

import 'SignUpDoctor.dart';

class PatiOrDoc extends StatelessWidget {
  const PatiOrDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: solcolor1,
      body: Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Healthy Steps',
                    style: TextStyle(fontSize: 28, fontFamily: 'font1'),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://i.pinimg.com/564x/96/65/1d/96651db840fa61e6ef727578d75632d3.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const SignUpPatient();
                      }));
                    },
                    style: b1,
                    child: const Text(
                      "Patient",
                      style: TextStyle(
                        fontFamily: 'font2',
                        color: solcolor3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const SignUpDoctor();
                      }));
                    },
                    style: b1,
                    child: const Text(
                      "Doctor",
                      style: TextStyle(
                        fontFamily: 'font2',
                        color: solcolor3,
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 10);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
