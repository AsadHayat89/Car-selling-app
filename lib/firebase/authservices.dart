import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjcars/Admin_Nav.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:mjcars/firebase/userNav.dart';
import 'package:mjcars/home.dart';
import 'package:mjcars/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  static var auth = FirebaseAuth.instance.currentUser;
  Future<String>? imgLink;
  static bool? exist;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Home_page();
          } else {
            return login_screen();
          }
        });
  }

  // signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser =
  //       await GoogleSignIn(scopes: <String>["email"]).signIn();
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser!.authentication;
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  ///****Create Account on firebase******/
  // static createStuwithemailandpass(String email, String password) async {
  //   try {
  //     // ignore: unused_local_variable
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     print('Created');
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  storeNewUser(user, BuildContext context) {
    FirebaseFirestore.instance.collection("/person").add({
      'email': user.email.toString(),
      'type':'User',
      'uid': user.uid.toString()
    }).then((value) {
      print("user added");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => login_screen()));
      // Get.snackbar(
      //   "snackbar",
      //   colorText: Colors.white,
      //   backgroundColor: Colors.lightBlue,
      //   icon: const Icon(Icons.add_alert),
      // );
      //const SnackBar(content: Text(" Account Succefully created"),);
      //Get.to(login_screen());
    }).catchError((e) {
      print(e);
    });
  }

  static signInWithEmailandPass(String email, String password,BuildContext context) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String usertype = "";
      String id="";
      print("emal is: "+email);

      QuerySnapshot snap = await firestore.collection("person").get();
      for (int i = 0; i < snap.docs.length; i++) {
        var a = snap.docs[i];
        DocumentSnapshot snap1 =
        await firestore.collection("person").doc(a.id).get();
        if(email==snap1['email']){
          usertype = snap1['type'];
          id=snap1['uid'];
        }

      }
      AuthServices().handleAuthState();
      print("login");
      if(usertype=="User"){
        var sessionManager = SessionManager();
        await sessionManager.set("email", email);
        await sessionManager.set("Type", "User");
        await sessionManager.set("Uid",id);
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => UserNav(),
          ),
              (route) => false,//if you want to disable back feature set to false
        );

      }
      else if(usertype=="Admin"){
        await SessionManager().set("email", email);
        await SessionManager().set("Type", "Admin");
        await SessionManager().set("Uid",id);
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => NavBar(),
          ),
              (route) => false,//if you want to disable back feature set to false
        );
      }
      else if(email=="admin@gmail.com"&&password=="1234567"){
        print("here aya1");
        await SessionManager().set("email", email);
        await SessionManager().set("Type", "Admin");
        await SessionManager().set("Uid",id);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (ctx) {
              return NavBar();
            }));
      }

      else{
        Get.snackbar("Error", "Invalid Credentials");
        //print("here aya2");
        // Navigator.pushAndRemoveUntil<dynamic>(
        //   context,
        //   MaterialPageRoute<dynamic>(
        //     builder: (BuildContext context) => UserNav(),
        //   ),
        //       (route) => false,//if you want to disable back feature set to false
        // );
        //Get.to(UserNav());
      }


      // else{Get.to(Home_page());}

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static add_car_data(var userData) async {
    await FirebaseFirestore.instance.collection('cars').add(userData);
  }
}
