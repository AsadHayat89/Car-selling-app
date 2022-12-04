import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/adminController.dart';
import 'QueryDetails.dart';
import 'model/query.dart';
import 'mycolors.dart';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({Key? key}) : super(key: key);

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var Controllervale=Get.put(AdminController());
  void getDetails() async{
    print("here aya ho");
    await firestore.collection("query")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        //Needs obj= new Need();
        //print("seen data:"+f['Userseen']);
        firestore.collection("query").doc(f.id).update({"adminSeen":"1"});

      });
    }
    );
    //print("Unseen data:"+ unseendata.toString());
    setState(() {
      Controllervale.Adminnotify.value=false;
      Controllervale.AdminnotifyValue.value=0;
      print("came here");
    });


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();

  }
  @override
  Widget build(BuildContext context) {


    Stream<QuerySnapshot> cropsStream =  firestore.collection("query").snapshots();
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: StreamBuilder(
          stream: firestore.collection("query").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                alignment: Alignment.center,
                child: Text('Nothing to Show'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                child: Text('Crops...'),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Container(
                alignment: Alignment.center,
                child: Text('No Crops has been Registered'),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document){
                return Padding(
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                  child: GestureDetector(
                    onTap: (){
                      //print("Document id: "+document.id);
                      if(document['replyStatus']=="0"){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => QueryDetail(DetailId:document.id,)));
                      }

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                            child: Text(document['date']['day'].toString()+"-"+document['date']['month'].toString()+"-"+document['date']['year'].toString(),style: TextStyle(fontSize: 16),),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],

                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:20,top: 20),
                                      child: Text("Car Color",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right:20,top: 20),
                                      child: Text(document['carColors'].toString(),style: TextStyle(fontSize: 16),),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:20,top: 10),
                                      child: Text("Car Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right:20,top: 10),
                                      child: Text(document['carType'].toString(),style: TextStyle(fontSize: 16),),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:20,top: 10),
                                      child: Text("Car Year",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right:20,top: 10),
                                      child: Text(document['carYear'].toString(),style: TextStyle(fontSize: 16),),
                                    )
                                  ],
                                ),

                                Padding(
                                  padding:EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 12.0,right: 5),
                                          child: Container(
                                            width: 10,
                                            height: 10,

                                            decoration: BoxDecoration(
                                                color: document['replyStatus']=="0"?Colors.redAccent:Colors.green,
                                                shape: BoxShape.circle
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right:20,top: 10),
                                        child: Text(document['replyStatus']=="0"?"pending":"Replyed"),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

            );
          },
        ));
  }
}
