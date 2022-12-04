import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mjcars/login.dart';
import 'package:mjcars/mycolors.dart';
import 'MyFavourite.dart';


import 'admin.dart';
import 'home.dart';

class UserNavbar extends StatefulWidget {
  const UserNavbar({Key? key}) : super(key: key);

  @override
  State<UserNavbar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<UserNavbar> {
  int ind=0;
  final screens=
  [

    Home_page(),
    MyFavourite(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[ind],
      bottomNavigationBar: ConvexAppBar(


        backgroundColor: myColor,
        style: TabStyle.react,
        items: const [

          TabItem(title:"Home",icon:Icons.home),
          TabItem(icon: Icons.favorite,title: "WishList")




        ],
        onTap:(index)
        {
          setState(() {
            ind=index;
            //myColor!=Colors.white?addColor=Colors.white:
          });
        },
      ),
    );

  }
}


