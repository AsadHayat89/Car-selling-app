// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mjcars/Detailpage.dart';
import 'package:mjcars/dialog.dart';
import 'package:mjcars/mycolors.dart';
import 'package:mjcars/paymentList.dart';
import 'package:mjcars/pdfView.dart';
import 'package:mjcars/searchbar/searchbar.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Controller/adminController.dart';
import 'constants/Constants.dart';
import 'data.dart';
import 'login.dart';
// ignore_for_file: prefer_const_constructors

class Home_page extends StatefulWidget {
  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  //late StreamSubscription _dailySpecialStream;
  var Controllervale=Get.put(AdminController());
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int unseendata=0;
  int adminSeen=0;
  var clr = Colors.grey;
  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();

  void getDetails() async{


    await firestore.collection("query")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        //Needs obj= new Need();
        print("seen data:"+f['Userseen']);
        if(f['Userseen']=="0") {
          setState(() {
            unseendata = unseendata + 1;
            //myColor!=Colors.white?addColor=Colors.white:
          });
        }
        print("seen data:"+f['adminSeen']);
        if(f['adminSeen']=="0"){
          setState(() {
            print("aya ho");
            adminSeen=adminSeen+1;
            //myColor!=Colors.white?addColor=Colors.white:
          });

        }
        });
      }
      );


    print("Unseen data:"+ unseendata.toString());
        if(unseendata>0){
          setState(() {
            Constants.notfiy=false;
            Controllervale.notify.value=true;
            Controllervale.notifyValue.value=unseendata;
            print("came here");
          });
        }
          print("admin data data:"+ adminSeen.toString());
          if(adminSeen>0){
            setState(() {
              Constants.notfiy=false;
              Controllervale.Adminnotify.value=true;
              Controllervale.AdminnotifyValue.value=adminSeen;
              print("came here");
            });
          }
        //firestore.collection("query").doc(f.id).update({"seen":"1"});




  }
  //var item;
  bool isloading = true;
  final List<String> _listItem = [
    'assets/audi3.png',
    'assets/audi.png',
    'assets/audi2.png',
    'assets/audi.png',
    'assets/audi2.png',
    'assets/audi3.png',
  ];
  var name;
  var auth1 = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase.instance.ref();
  Data? c;
  late final Value;
  List<Data> dataList = [];
  List<dynamic> d = [];
  List<dynamic> favList = [];
  String UserName="";
  @override
  void initState() {
    print("object");
    super.initState();
    print(auth1);
   getDetails();
    if(unseendata>0){
      setState(() {
        print("came here");
        Controllervale.notify.value=false;
        Controllervale.notifyValue.value=unseendata;
      });
    }
    print("admin data data:"+ adminSeen.toString());
    if(adminSeen>0){
      setState(() {
        Constants.notfiy=false;
        Controllervale.Adminnotify.value=true;
        Controllervale.AdminnotifyValue.value=unseendata;
        print("came here");
      });
    }
    _activateListener();
  }

  // void addShow() async{
  //   var data1 = (await FirebaseFirestore.instance
  //       .collection('listofprods')
  //       .where(field)
  //       .get())
  //       .data['name']
  //       .toString();
  // }
  void _activateListener() async {
    // final database = FirebaseDatabase.instance.ref();

    await database.child('user').get().then((snapshot) async {
      dataList.clear();
      favList.clear();

      print("hello");

      Value = snapshot.value as Map;
      final datas = snapshot.children.forEach((element) {
        d.add(element.key);
      });
      try {
        if (mounted) {
          // showAlertDialog(
          //   context,
          // );
        }
        for (var k in d) {
          print(k);
          print(Value[k]['imgUrl']);
          print((Value[k]['carName']).runtimeType);

          Data data = Data(
            Value[k]['carName'],
            Value[k]['price'],
            Value[k]["imgUrl"],
            k,
          );
          dataList.add(data);

          if (auth1 != null) {
            DatabaseReference reference = FirebaseDatabase.instance
                .ref()
                .child("user")
                .child(k)
                .child("fav")
                .child(auth1!.uid)
                .child("state");
            DatabaseEvent event = await reference.once();

            print("upp is vla");
            if (event.snapshot.value != null) {
              if (event.snapshot.value == true) {
                favList.add(true);
                print(favList);
              } else {
                print("false1");
                favList.add(false);
              }
            } else {
              print("inelse");
              favList.add(false);
              print(favList);
            }
          }
        }
        // Navigator.pop(context);
      } on Exception {}

      if (mounted) {
        setState(() {
          //
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child:Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(),
          body: wholeHome(context),
        ),

    );
  }
  Widget DrawerWidget(){
    return Drawer(
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:EdgeInsets.only(top: 20),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: new BoxDecoration(
                    color: myColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person,color: Colors.white,size: 86,),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(FirebaseAuth.instance.currentUser!.email.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text("View Profile",style: TextStyle(fontSize: 18,color: Colors.blueAccent),),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Container(
                    width: 230,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My Notifications",style: TextStyle(color: myColor,fontSize: 18,fontWeight: FontWeight.bold),),

                        Icon(FontAwesomeIcons.bell,color: myColor,)
                      ],
                    ),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: 230,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Save Ads",style: TextStyle(color: myColor,fontSize: 18,fontWeight: FontWeight.bold),),

                        Icon(FontAwesomeIcons.download,color: myColor,)
                      ],
                    ),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap:(){
                      print("ehre");
                      Get.to(() => PdfView());
                      //Get.to(PdfView());
                    },
                    child: Container(
                      width: 230,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Certificate",style: TextStyle(color: myColor,fontSize: 18,fontWeight: FontWeight.bold),),

                          Icon(FontAwesomeIcons.certificate,color: myColor,)
                        ],
                      ),
                    ),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap:(){
                      Get.to(PaymentDetails());
    },
                    child: Container(
                      width: 230,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax Payment detatils",style: TextStyle(color: myColor,fontSize: 18,fontWeight: FontWeight.bold),),

                          Icon(FontAwesomeIcons.moneyCheckDollar,color: myColor,)
                        ],
                      ),
                    ),
                  )
              ),

            ],
          ),
          GestureDetector(
            onTap: () async{
              await SessionManager().destroy();
              await FirebaseAuth.instance.signOut();
              print("print signout");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx) {
                    return login_screen();
                  }));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Logout",style: TextStyle(color: myColor,fontSize: 20),),
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: new BoxDecoration(
                      color: myColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Icon(Icons.logout,color: Colors.white,size: 35,),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
  Container wholeHome(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Image.asset(
            "assets/top.png",
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: GestureDetector(
                      onTap:()=> _scaffoldKey.currentState?.openDrawer(),
                        child: Icon(
                      FontAwesomeIcons.bars,
                      color: myColor,
                    )),
                  ),

                ],
              ),
              search(context, searchMethod),
              SizedBox(
                height: 80,
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                children:
                    List.generate(dataList.length, (index) => GridDesign(index))
                        .toList(),
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget MainPageUser() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Image.asset(
            "assets/top.png",
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              search(context, searchMethod),
              SizedBox(
                height: 80,
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                children:
                    List.generate(dataList.length, (index) => GridDesign(index))
                        .toList(),
              )),
            ],
          )
        ],
      ),
    );
  }

  SizedBox GridDesign(int index) {
    print("index value is: "+index.toString());

    return SizedBox(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 13.h,
                width: 45.w,
                margin: EdgeInsets.only(left: 12, top: 12, right: 16),
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey,style: BorderStyle.solid,width: 2),
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(dataList[index].url[0].toString()),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                bottom: -3,
                right: 5,
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: Neumorphic(
                      padding: EdgeInsets.zero,
                      style: NeumorphicStyle(
                          //shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(50)),
                          color: Colors.white),
                      child: favList[index]
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (auth1 != null) {
                                  print(auth1);
                                  print("it's not null");
                                  DatabaseReference favRef = FirebaseDatabase
                                      .instance
                                      .ref()
                                      .child("user")
                                      .child(
                                          dataList[index].uploadId.toString())
                                      .child("fav")
                                      .child(auth1!.uid)
                                      .child("state");
                                  favRef.set(false);
                                  setState(() {
                                    favFun(index,
                                        dataList[index].uploadId.toString());
                                  });
                                }

                                print("object");
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            )
                          : IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (auth1 != null) {
                                  print("it's not null1");
                                  print(auth1);
                                  DatabaseReference favRef = FirebaseDatabase
                                      .instance
                                      .ref()
                                      .child("user")
                                      .child(
                                          dataList[index].uploadId.toString())
                                      .child("fav")
                                      .child(auth1!.uid)
                                      .child("state");
                                  favRef.set(true);
                                  setState(() {
                                    favFun(index,
                                        dataList[index].uploadId.toString());
                                  });
                                }

                                print("object");
                              },
                              icon: Icon(
                                Icons.favorite,
                              ))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 0.2.h,
          ),
          Expanded(child: Text(dataList[index].CarName.toString())),
          SizedBox(height: 0.1),
          Expanded(
            child: Text("PKR${dataList[index].price}"),
          ),
          SizedBox(height: 0.2),
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              print("asad");
              //print(dataList[index].Url[0]);
              Get.to(DetailPage(dataList[index].Url[1], dataList[index].Price));
            },
            style: ElevatedButton.styleFrom(primary: myColor),
            child: Text("Details"),
          ))
        ],
      ),
    );
  }

  void favFun(int i, var a) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("user");
    ref.get().then((snapshot) async {
      if (auth1 != null) {
        DatabaseReference reference = FirebaseDatabase.instance
            .ref()
            .child("user")
            .child(a)
            .child("fav")
            .child(auth1!.uid)
            .child("state");

        DatabaseEvent event = await reference.once();

        if (event.snapshot.value != null) {
          if (event.snapshot.value == true) {
            print("hel");
            setState(() {
              favList[i] = true;
              print(favList);
            });
          } else {
            //print(s.value);
            // print("false1");
            //favList.add(false);
            setState(() {
              favList[i] = false;
              print(favList);
            });

            //print(favList);
          }
        } else {
          print("inelse");
          favList.add(false);
          print(favList);
        }
      }

      // }

      // Timer(Duration(seconds: 1), () {
      setState(() {
        //inspect(favList);
      });
    });
  }

  void searchMethod(String text) {
    DatabaseReference searchRef = FirebaseDatabase.instance.ref().child("user");
    searchRef.once().then((snapshot) {
      dataList.clear();
      for (var k in d) {
        Data data = Data(
          Value[k]['carName'],
          Value[k]['price'],
          Value[k]["imgUrl"],
          k,
        );
        if (data.carName!.contains(text)) {
          dataList.add(data);
        }
      }
      Timer(Duration(seconds: 1), () {
        setState(() {});
      });
    });
  }
}

checkConnectivity(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  switch (connectivityResult) {
    case ConnectivityResult.wifi:

    case ConnectivityResult.mobile:
      // print("mobile");
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
        }
      } on SocketException catch (_) {
        _showMyDialog(context);
      }

      break;
    case ConnectivityResult.none:
      _showMyDialog(context);

      break;
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('⚠ No Internet'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Check your internet connection!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
