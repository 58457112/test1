import 'package:flutter/material.dart';
import 'package:test1/ressources/consts_global.dart';

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  TextEditingController agecontroller = TextEditingController();
  TextEditingController poidscontroller = TextEditingController();
  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Bonne journée !',
                    style: TextStyle(fontSize: 25, fontFamily: 'font1'),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.waving_hand,
                    color: Colors.amber,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Merci de remplir le formulaire ci-dessous avec vos informations personnelles pour que nous puissions mieux vous connaître et vous fournir des soins adaptés à vos besoins.",
                style: TextStyle(fontSize: 16, fontFamily: 'font3'),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(image: AssetImage('assets/Form.png'))),
              SizedBox(
                width: 300.0,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter Email";
                    }
                    bool emailvalid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailvalid) {
                      return "enter email";
                    }
                  },
                  controller: agecontroller,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: solcolor1,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(color: solcolor1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(color: Colors.blue),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "enter Email";
                      }
                      bool emailvalid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailvalid) {
                        return "enter email";
                      }
                    },
                    controller: poidscontroller,
                    decoration: InputDecoration(
                      labelText: 'Poids',
                      contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                      prefixIcon: Icon(
                        Icons.person,
                        color: solcolor1,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide: BorderSide(color: solcolor1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                title: Text(
                  'Est-ce que vous souffrez de maladies ?',
                  style: TextStyle(fontFamily: 'font3'),
                ),
                value: _isChecked,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isChecked = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: Icon(
                  Icons.medical_services,
                  color: solcolor1,
                ),
                activeColor: solcolor1,
                checkColor: Colors.white,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
