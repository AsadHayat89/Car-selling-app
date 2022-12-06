import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mjcars/UserNav.dart';
import 'package:mjcars/admin.dart';
import 'package:mjcars/firebase/authservices.dart';
import 'package:mjcars/firebase/userNav.dart';
import 'package:mjcars/mycolors.dart';
import 'package:mjcars/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'Admin_Nav.dart';
import 'home.dart';
import 'login.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String errorTex = "";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool passenable = false;
  bool showcricle = false;
  final emailController = TextEditingController();
  String Passerror = "";
  int emailerror = 0;
  final passwordController = TextEditingController();

  Widget login(IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: BorderSide(
          color: Colors.grey.withOpacity(1),
          width: 1,
        ),
      ),
      elevation: 20,
      child: Neumorphic(
        child: Container(
          //padding: EdgeInsets.all(2),
          height: 50,
          width: 115,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24),
              TextButton(
                  onPressed: () {
                   // Get.to(signup());
                  },
                  child:
                  Text('Sign UP', style: TextStyle(color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) =>
      Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Neumorphic(
          style: NeumorphicStyle(
              boxShape:
              NeumorphicBoxShape.roundRect(BorderRadius.circular(50))),
          child: Container(
            height: 6.h,
            width: 90.w,
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 22, right: 25),
              child: TextField(
                onChanged: (value) {
                  print("asd");
                  setState(() {
                    this.errorTex = "";
                  });
                },
                controller: userInput,
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
                decoration: InputDecoration.collapsed(
                  hintText: hintTitle,
                  hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                      fontStyle: FontStyle.italic),
                ),
                keyboardType: keyboardType,
              ),
            ),
          ),
        ),
      );

  Widget PassordInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) =>
      Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Neumorphic(
          style: NeumorphicStyle(
              boxShape:
              NeumorphicBoxShape.roundRect(BorderRadius.circular(50))),
          child: Container(
            height: 6.h,
            width: 90.w,
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 22, right: 25),
              child: TextField(
                onChanged: (value) {
                  print("asd");
                  setState(() {
                    this.errorTex = "";
                  });
                },
                obscureText: passenable,
                controller: userInput,
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: hintTitle,
                  suffix: IconButton(
                      onPressed: () {
                        //add Icon button at end of TextField
                        setState(() {
                          //refresh UI
                          if (passenable) {
                            //if passenable == true, make it false
                            print("data1");
                            passenable = false;
                          } else {
                            print("data2");
                            passenable =
                            true; //if passenable == false, make it true
                          }
                        });
                      },
                      icon: Icon(passenable == true
                          ? Icons.remove_red_eye
                          : Icons.password)),
                  hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                      fontStyle: FontStyle.italic),
                ),
                keyboardType: keyboardType,
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              //alignment: Alignment.topCenter,
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/background.png',
              ),
            ),
          ),
          child: showcricle
              ? Center(child: CircularProgressIndicator())
              : Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: userInput(emailController, 'Email',
                        TextInputType.emailAddress),
                  ),
                  if (this.errorTex != "")
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        this.errorTex.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),

                  // Text(
                  //   "data1",
                  //   textAlign: TextAlign.start,
                  // ),
                  SizedBox(
                    height: 10,
                  ),

                  // Center(
                  //   child: Text(
                  //     this.errorTex,
                  //     style: TextStyle(
                  //         color: Colors.red,
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      //height: 55,

                      padding: const EdgeInsets.only(
                          top: 5, left: 70, right: 70),
                      // ignore: deprecated_member_use
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(myColor),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          print("Controller emaik: "+emailController.text);
                          await _firebaseAuth.sendPasswordResetEmail(email: emailController.text);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => login_screen()));
                          //
                        },
                        child: Text(
                          'Send',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
