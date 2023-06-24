import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:test1/controllers/notificationControler.dart';
import 'package:test1/notif.dart';
import 'package:test1/ressources/consts_global.dart';
import 'package:test1/screens/UpdatePassword.dart';

import '../controllers/updateController.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationController notificationController =
      Get.put(NotificationController());
  UpdateController updateController = Get.put(UpdateController());
  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController.todayAppointment();

    Noti.initialize(flutterLocalNotificationsPlugin);
  }

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
                          'https://i.pinimg.com/564x/90/7f/f2/907ff2406900b0d246924c1539ae9bc5.jpg')),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Forget Password ?',
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'font3',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Please enter your registered email address we will get back to you with the reset password link and confirmation ...thanks',
                style: TextStyle(fontFamily: 'font3', fontSize: 16),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Entrez votre e-mail',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  updateController.emailReset(emailController.text);
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: solcolor1,
                      borderRadius: BorderRadius.circular(60)),
                  child: const Center(
                      child: Text(
                    "Submit",
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
