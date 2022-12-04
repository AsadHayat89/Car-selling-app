// ignore_for_file: prefer_const_constructors
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

class login_screen extends StatefulWidget {
  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  //static const routeName = '/login-screen';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String errorTex = "";
  bool passenable=false;
  bool showcricle=false;
  final emailController = TextEditingController();
  String  Passerror = "";
  int emailerror = 0;
  final passwordController = TextEditingController();

  @override
  Future<void> googleSignup(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>[
        'https://www.googleapis.com/auth/drive',
      ],
    );
    GoogleSignInAccount? googleUser;
    try {
      print("here0");
      googleUser = await googleSignIn.signIn();
      print("here1");
      if (googleUser != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
      }
      print("here");
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('email', googleUser!.email.toString());
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return UserNav();
      }));
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled') {
        print('sign_in_canceled');
      } else if (e.code == 'sign_in_failed') {
        print('sign_in_failed');
      }
    }
    if (googleUser == null) return;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('Successfully Signed up');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exist-with-different-credential') {
        print('account already exist with different credential');
      } else if (e.code == 'invalid-credential') {
        print('Error occurred while accessing credentials. Try again.');
      } else {
        print('Error occurred using Google Sign In. Try again.');
      }
    }
  }

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
                    Get.to(signup());
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
                  suffix: IconButton(onPressed: (){ //add Icon button at end of TextField
                    setState(() { //refresh UI
                      if(passenable){ //if passenable == true, make it false
                        print("data1");
                        passenable = false;
                      }else{
                        print("data2");
                        passenable = true; //if passenable == false, make it true
                      }
                    });
                  }, icon: Icon(passenable == true?Icons.remove_red_eye:Icons.password)),
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
          child: showcricle?Center(child: CircularProgressIndicator()):Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: userInput(
                        emailController, 'Email', TextInputType.emailAddress),
                  ),
                  if(this.errorTex!="")
                  Padding(
                    padding:  EdgeInsets.only(left: 40),
                    child: Text(this.errorTex.toString(),style: TextStyle(color: Colors.red,fontSize: 14),),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: userInput(passwordController, 'Password',
                        TextInputType.visiblePassword),
                  ),
                  if(this.Passerror!="")
                  Padding(
                    padding:  EdgeInsets.only(left: 40),
                    child: Text(this.Passerror.toString(),style: TextStyle(color: Colors.red,fontSize: 14),),
                  ),
                  // Text(
                  //   "data1",
                  //   textAlign: TextAlign.start,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Forgot password ?',
                      style: TextStyle(
                          color: myColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15),
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

                      padding: const EdgeInsets.only(top: 5, left: 70, right: 70),
                      // ignore: deprecated_member_use
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(myColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          var res = EmailValidator.validate(emailController.text);
                          //print("result  "+ res.toString());
                          if (res == true) {
                            if(passwordController.text.length>=7){
                              print("here1");
                              checkConnectivity(context);
                              setState(() {
                                this.showcricle=true;
                              });

                              await AuthServices.signInWithEmailandPass(
                                  emailController.text, passwordController.text,context);
                              setState(() {
                                this.showcricle=false;
                                this.errorTex = "Email is invalid";
                                this.Passerror = "Incorrect Password";

                              });
                              bool? n = AuthServices.exist;

                              if (n != null) Get.to(Admin());
                            }
                            else{
                              setState(() {
                                this.Passerror="Password should be greater then 7";
                              });
                            }
                          } else {
                            setState(() {
                              this.errorTex = "Email is invalid";
                              //this.Passerror = "Incorrect Password";

                            });
                          }
                          //
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.white10,
                                  Colors.white,
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 1.0),
                                stops: <double>[0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: 100.0,
                          height: 1.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            'Or',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'WorkSansMedium'),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.white,
                                  Colors.white10,
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 1.0),
                                stops: <double>[0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: 100.0,
                          height: 1.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: InkWell(
                          onTap: () {
                            googleSignup(context);
                          },
                          child: Image.asset(
                            "assets/google.png",
                            height: 50,
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          text: "Dont't have account?",
                          style: TextStyle(
                              color: myColor, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: " Signup",
                              style: TextStyle(
                                color: Color.fromARGB(255, 23, 116, 210),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("fg");
                                  Get.to(signup());
                                },
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
