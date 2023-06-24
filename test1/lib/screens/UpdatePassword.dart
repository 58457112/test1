import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test1/ressources/consts_global.dart';

import '../controllers/updateController.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController Newpassword = TextEditingController();
  final TextEditingController resetCode = TextEditingController();
  UpdateController updateController = Get.put(UpdateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Container(
                  color: Colors.white.withOpacity(0.95),
                  child: Image(
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/ec/42/e5/ec42e519ef86d1e4cd63f880414db54f.jpg')),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Reset Password ?',
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'font3',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hello ... You have requested a reset of your password. To continue, please choose another password',
                style: TextStyle(fontFamily: 'font3', fontSize: 16),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: resetCode,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Reset code ',
                  hintText: 'Enter the reset code',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: Newpassword,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter new password',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  updateController.updatePassword(
                      Newpassword.text, resetCode.text);
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: solcolor1,
                      borderRadius: BorderRadius.circular(60)),
                  child: const Center(
                      child: Text(
                    "Confirm",
                    style: TextStyle(fontFamily: 'font2'),
                  )),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
