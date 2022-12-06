// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mjcars/dialog.dart';
import 'package:mjcars/firebase/userNav.dart';
import 'package:mjcars/home.dart';
import 'package:mjcars/mycolors.dart';
import 'package:sizer/sizer.dart';

import 'Detailpage.dart';
import 'data.dart';

class MyFavourite extends StatefulWidget {
  const MyFavourite({Key? key}) : super(key: key);

  @override
  State<MyFavourite> createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  final auth1 = FirebaseAuth.instance.currentUser;
  List<Data> dataList = [];
  List d = [];
  final database = FirebaseDatabase.instance.ref().child('user');

  // ignore: prefer_typing_uninitialized_variables
  var Value;
  @override
  initState() {
    print("object");

    print(auth1);
    _activateListener();
    super.initState();
  }

  _activateListener() async {
    await database.get().then(
      (snapshot) {
        dataList.clear();

        print("hello");

        Value = snapshot.value as Map;
        final datas = snapshot.children.forEach((element) {
          d.add(element.key);
        });

        for (var k in d) {
          print("data :"+k.toString());
          if (mounted) {
            showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black12,
                context: context,
                builder: (context) {
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.of(context).pop(true);
                  });
                  return SpinKitThreeBounce(
                    //duration: const Duration(seconds: 2),
                    size: 40,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: myColor,
                        ),
                      );
                    },
                  );
               });
          }
          //print("");
          print(Value[k]['imgUrl']);
          print((Value[k]['carName']).runtimeType);
          // ignore: unnecessary_new
          Data data = new Data(
            Value[k]['carName'],
            Value[k]['price'],
            Value[k]["imgUrl"],
            k,
          );

          if (auth1 != null) {
            // print(k);
            // print("auth1");
            //print(auth1);
            DatabaseReference reference = FirebaseDatabase.instance
                .ref()
                .child("user")
                .child(k)
                .child("fav")
                .child(auth1!.uid)
                .child("state");

            reference.get().then(
              (s) {
                //print(s.value);
                print("upp is vla");
                if (s.value != null) {
                  if (s.value == true) {
                    // print(s.value);
                    // print("true");

                    dataList.add(data);
                  }
                }
              },
            );
          }
        }

        Timer(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              //inspect(favList);
            });
          }
        });
      },
    ); //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("My Favourite"),
          backgroundColor: myColor,
          centerTitle: true,
        ),
        body:  wholeHome(context),
      ),
    );
  }

  Container wholeHome(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
              child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            children:
                List.generate(dataList.length, (index) => GridDesign(index))
                    .toList(),
          )),
        ],
      ),
    );
  }

  SizedBox GridDesign(int index) {
    return SizedBox(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 13.h,
                width: 45.w,
                margin: const EdgeInsets.only(left: 12, top: 12, right: 16),
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey,style: BorderStyle.solid,width: 2),
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(dataList[index].url.toString()),
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
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // FirebaseAuth.instance
                          //     .userChanges()
                          //     .listen(
                          //         (User? user) {
                          //   if (user != null) {
                          //     print(
                          //         'User is currently signed in!');
                          //         DatabaseReference favRef=FirebaseDatabase.instance.ref().child("user").child(dataList[index].uploadId.toString()).child("fav").child(auth1!.uid).child("state");
                          //         favRef.set(false);
                          //         setState(() {
                          //   favFun();
                          // });
                          //   } else {
                          //     print(
                          //         'User is signed in!');
                          //   }
                          // });
                          if (auth1 != null) {
                            print(auth1);
                            print("it's not null");
                            DatabaseReference favRef = FirebaseDatabase.instance
                                .ref()
                                .child("user")
                                .child(dataList[index].uploadId.toString())
                                .child("fav")
                                .child(auth1!.uid)
                                .child("state");
                            favRef.set(false);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return AlertDialog(
                                    content: Row(
                                      children: [
                                        const CircularProgressIndicator(),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(left: 25),
                                            child: const Text("Removing..."))
                                      ],
                                    ),
                                  );
                                });
                            dataList.removeAt(index);
                            setState(() {});
                          }

                          print("object");
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Expanded(child: Text(dataList[index].CarName.toString())),
          const SizedBox(height: 2),
          Expanded(
            child: Text("PKR${dataList[index].price}"),
          ),
          const SizedBox(height: 3),
          Expanded(
              child: ElevatedButton(
            onPressed: (){
               Get.to(DetailPage(dataList[index].Url, dataList[index].Price,dataList[index].Url));
            },

            style: ElevatedButton.styleFrom(primary: myColor),
            child: const Text("Details"),
          ))
        ],
      ),
    );
  }
}
