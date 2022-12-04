// ignore_for_file: prefer_const_constructors

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mjcars/splash.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey="pk_test_51M2TlrIyZcrUZatMJdZyAsGdcbeo7lmI7Htr5FThBQ10uJ6FK9KeJoDuDf99URfKADMDOQ4kWQIdp5CsKhDeJ2ru00gcVYwrQZ";
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
      Sizer (
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mj Cars',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:MyHomePage()
             );
          },
       );
  }
}

