import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mjcars/login.dart';
import 'package:mjcars/mycolors.dart';
import 'Controller/adminController.dart';
import 'MyFavourite.dart';


import 'admin.dart';
import 'adminNotifications.dart';
import 'adminhome/AdminHome.dart';
import 'constants/Constants.dart';
import 'home.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavigationBarState();


}

class _NavigationBarState extends State<NavBar> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var Controllervale=Get.put(AdminController());
  int count=0;
  bool notfiy=false;
  void checkNavigations() async{
    QuerySnapshot docSnapshot = await firestore.collection('query').get();
    docSnapshot.docs.map((doc) => print("asad: "+doc['Email'].toString())).toList();

    QuerySnapshot querySnapshot = await firestore.collection('query').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var docSnapshot = await firestore.collection('query').doc(querySnapshot.docs[i].id).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        setState((){
          String getrpicea=data?["replyPrice"];
          if(getrpicea!="0"){
            this.notfiy=true;
            count=count+1;
          }
        });

        //print("Value:  "+value.toString());// <-- The value you want to retrieve.
        // Call setState if needed.
      }

    }
    // if (docSnapshot.) {
    //   Map<String, dynamic>? data = docSnapshot.docs;
    //   setState((){
    //     phone = data?['Phone'];
    //     email= data?['Email'];
    //     address=data?['Address'];
    //     carType=data?['carType'];
    //     carYear=data?['carYear'];
    //     carcolor=data?['carColors'];
    //   });
    //
    //   //print("Value:  "+value.toString());// <-- The value you want to retrieve.
    //   // Call setState if needed.
    // }
  }
  int unseedata=0;
  int ind=0;
  final screens=
  [

    AdminHome(),
    Admin(),
    const MyFavourite(),
    AdminNotifications(),
  ];

  @override
  void initState() {
    // TODO: implement initState

    checkNavigations();
    super.initState();

  }

  void getDetails() async{


    await firestore.collection("query")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        //Needs obj= new Need();
        print("seen data:"+f['Userseen']);
        if(f['Userseen']=="0"){
          setState(() {
            unseedata=unseedata+1;
            //myColor!=Colors.white?addColor=Colors.white:
          });

        }
        print("Unseen data:"+ unseedata.toString());
        //firestore.collection("query").doc(f.id).update({"seen":"1"});

      });
    }
    );


  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        body: screens[ind],
        bottomNavigationBar: ConvexAppBar(


          backgroundColor: myColor,
          style: TabStyle.react,
          items:  [

            TabItem(title:"Home",icon:Icons.home),
            TabItem(title:"Add Car",icon:Icons.add),
            TabItem(icon: Icons.favorite,title: "WishList"),
            Controllervale.Adminnotify==false?TabItem(icon: Icons.notifications, title: "Notificatio"):TabItem(icon: new Stack(
              children: <Widget>[
                new Icon(Icons.notifications,color: Colors.white54,),
                new Positioned(
                  right: 0,
                  child: new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: new Text(
                      Controllervale.AdminnotifyValue.toString(),
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
              title: 'Notifications',
            ),


          ],
          onTap:(index)
          {
            setState(() {
              ind=index;
              //myColor!=Colors.white?addColor=Colors.white:
            });
          },
        ),
      ),
    );
    
  }
}


