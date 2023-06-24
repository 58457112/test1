import 'package:flutter/material.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:test1/screens/LoginOrSignUp.dart';

class Welcome1 extends StatelessWidget {
  const Welcome1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: solcolor1,
      body: Center(
          child: Column(
        children: <Widget>[
          const SizedBox(
            height: 90.0,
          ),
          const Text('Health Bridge',
              textAlign: TextAlign.center, style: solhealth),
          const SizedBox(
            height: 40.0,
          ),
          const Image(image: solGetstarted),
          const Text('Make it Easy',
              textAlign: TextAlign.center, style: solmakeit),
          const SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const LoginOrSignUp();
              }));
            },
            style: b1,
            child: const Text(
              "Get Started",
              style: TextStyle(
                fontFamily: 'font2',
                color: solcolor3,
              ),
            ),
          )
        ],
      )),
    );
  }
}
