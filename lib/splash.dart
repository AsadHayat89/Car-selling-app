import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:mjcars/Admin_Nav.dart';
import 'package:mjcars/firebase/userNav.dart';
import 'package:mjcars/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  String emaildata="";
  String typedata="";
  void checkSession() async{
    // String email = await SessionManager().get("email");
    // String type=await SessionManager().get("Type");
    // print("email data:  "+email);
    // emaildata=email;
    // typedata=type;
    // print("Type data:  "+type);
  }
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    //checkSession();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/Splash.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward().whenComplete(() async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    bool res=await SessionManager().containsKey("email");
                    print("result: "+res.toString());
                      if(res){
                        String type=await SessionManager().get("Type");
                        if(type=="User"){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx) {
                                return UserNav();
                              }));
                        }
                        else if(type=="Admin"){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx) {
                                return NavBar();
                              }));
                        }
                        else{
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx) {
                                return login_screen();
                              }));
                        }
                      }
                      else{
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) {
                              return login_screen();
                            }));
                      }


                  });
              },
            ),
          ],
        ),
      ),
    );
  }
}
