import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:mjcars/firebase/authservices.dart';
import 'package:mjcars/login.dart';
import 'package:mjcars/mycolors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:async';
class signup extends StatefulWidget {
  signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  static const routeName = '/login-screen';
  String emailerror = "";
  String passerror = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String dropdownvalue = 'User';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 //   Timer.periodic(Duration(seconds: 3),(_)=>checkEamil());
  }

  // void checkEmail(){
  //   FirebaseAuth.instance.currentUser.reactive();
  //
  // }
  // List of items in our dropdown menu
  var items = [
    'User',
    'Admin',
  ];

  @override
  Widget login(IconData icon) {
    return Container(
      child: RichText(
        text: TextSpan(
          text: "Already have account? ",
          style: TextStyle(color: myColor, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              style: const TextStyle(
                  color: Color.fromARGB(255, 23, 116, 210), fontSize: 15),
              text: "Login",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(login_screen());
                },
            )
          ],
        ),
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: Colors.white.withOpacity(1), width: 2),
      ),
      elevation: 10,
      shadowColor: Colors.black,
      child: Neumorphic(
        style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50))),
        child: Container(
          height: 55,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100)),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  if (hintTitle == "Email") {
                    this.emailerror = "";
                  } else {
                    this.passerror = "";
                  }
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
  }

  Widget ShowList() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: Colors.white.withOpacity(1), width: 2),
      ),
      elevation: 10,
      shadowColor: Colors.black,
      child: Neumorphic(
        style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50))),
        child: Container(
          width: 400,
          height: 55,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100)),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25),
            child: DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/background.png',
              ),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 510,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 45),
                              userInput(emailController, 'Email',
                                  TextInputType.emailAddress),
                              this.emailerror != ""
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(top: 5,left: 30),
                                      child: Container(
                                        width: MediaQuery. of(context). size. width,
                                          child: Text(
                                        this.emailerror,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 14),
                                      )),
                                    )
                                  : SizedBox(),
                              const SizedBox(height: 13),
                              userInput(passwordController, 'Password',
                                  TextInputType.visiblePassword),
                              this.passerror != ""
                                  ? Container(
                                width: MediaQuery. of(context). size. width,
                                    child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 5,left: 30),
                                        child: Text(
                                          this.passerror,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 14),
                                        ),
                                      ),
                                  )
                                  : SizedBox(),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 55,
                                // for an exact replicate, remove the padding.
                                // pour une réplique exact, enlever le padding.
                                padding: const EdgeInsets.only(
                                    top: 3, left: 70, right: 70),
                                // child: RaisedButton(
                                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                //   color: myColor,
                                //   onPressed: () {
                                //    AuthServices.createStuwithemailandpass(emailController.text, passwordController.text);
                                //   },
                                //   child: const Text('Signup', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                                // ),

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
                                  onPressed: () {
                                    // AuthServices.createStuwithemailandpass(
                                    //     emailController.text,
                                    //     passwordController.text);
                                    CreateUser();
                                  },
                                  child: const Text(
                                    'Signup',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              //SizedBox(height: 20),
                              //Center(child: Text('Forgot password ?'),),
                              //SizedBox(height: 20,),

                              //SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //login(Icons.add),
                                    login(Icons.book_online),
                                  ],
                                ),
                              ),
                              // Divider(thickness: 0, color: Colors.white),
                              /*
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Text('Don\'t have an account yet ? ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                              TextButton(
                              onPressed: () {},
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ),
                            ],
                          ),
                            */
                            ],
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

  void CreateUser() async{
    var res = EmailValidator.validate(emailController.text);
    if (res == true) {
      if (passwordController.text.length >= 7) {
        try {
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((signedInUser)

          {
            // User? user= FirebaseAuth.instance.currentUser;
            // user?.sendEmailVerification();
            // FirebaseAuth.instance.currentUser?.reload();
            AuthServices().storeNewUser(signedInUser.user, context);
          }).catchError((e) {
            if (e == 'Password should be at least 6 characters') {
              print("pass is weak");
            }
            print(e);
          });
        } catch (e) {
          print("ewer");
          print(e);
        }
      } else {
        print("asad");
        setState(() {
          this.passerror = "Password should be greater than 7";
        });
      }
    } else {
      setState(() {
        this.emailerror = "Invalid Email";
      });
    }
  }
}
