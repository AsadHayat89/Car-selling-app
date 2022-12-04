import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mjcars/CarSubmissionForm.dart';
import 'package:mjcars/MyFavourite.dart';
import 'package:mjcars/home.dart';
import 'package:mjcars/mycolors.dart';

import '../Controller/adminController.dart';
import '../adminNotifications.dart';
import '../payment/payment.dart';
import '../userNotification.dart';

class UserNav extends StatefulWidget {
  @override
  State<UserNav> createState() => _UserNavState();
}

class _UserNavState extends State<UserNav> {
  int index = 0;
  var Controllervale=Get.put(AdminController());
  final screens = [
    Home_page(),
    const CarForm(),
    const MyFavourite(),
    UserNotifications(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
          ()=> Scaffold(
            body: screens[index],
            bottomNavigationBar: ConvexAppBar(
              style: TabStyle.react,
              backgroundColor: myColor,
              items:  [
                TabItem(title: 'Home', icon: Icons.home),
                TabItem(icon: Icons.add, title: "Import Car"),
                TabItem(icon: Icons.favorite, title: "Fav"),
                Controllervale.notify==false?TabItem(icon: Icons.notifications, title: "Notificatio"):TabItem(icon: new Stack(
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
                          Controllervale.notifyValue.toString(),
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
              onTap: (index) {
                setState(() {
                  this.index = index;
                  //myColor!=Colors.white?addColor=Colors.white:
                });
              },
            )),
      ),
    );
  }
}
