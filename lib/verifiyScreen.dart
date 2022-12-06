import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mjcars/mycolors.dart';

import 'firebase/authservices.dart';
import 'login.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer t;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = auth.currentUser!;
    user.sendEmailVerification();
    t = Timer.periodic(Duration(seconds: 2), (timer) {
      checkVerificationEmail();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    t.cancel();
  }

  void sendEmail() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column
        (
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Center(child: Text("Please verify your Email first",style: TextStyle(fontSize: 18),)),
            Padding(
              padding: EdgeInsets.only(top: 7),
              child: Center(child: Text(user.email.toString(),style: TextStyle(fontSize: 16,color: myColor),)),
            ),
      ]),
    );
  }

  Future<void> checkVerificationEmail() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      t.cancel();
      AuthServices().storeNewUser(user, context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => login_screen()));
    }
  }
}
