import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  @override
  Widget build(BuildContext context) {

    FirebaseAuth _auth=FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Stream<QuerySnapshot> cropsStream =  firestore.collection("payment").where('User',isEqualTo:FirebaseAuth.instance.currentUser?.email).orderBy("dateNumber",descending: false).snapshots();
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.shade300,
          child: StreamBuilder(
            stream: firestore.collection("payment").where('User',isEqualTo:FirebaseAuth.instance.currentUser?.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Container(
                  alignment: Alignment.center,
                  child: Text('Crops could not be loaded'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  alignment: Alignment.center,
                  child: Text('Loading Crops...'),
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
                        // if(document['replyStatus']=="1"){
                        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserQueryDetail(DetailId:document.id,)));
                        // }

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
                              child: Text(document['date'],style: TextStyle(fontSize: 16),),
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
                                        child: Text("Payment",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right:20,top: 20),
                                        child: Text(document['Ammount'].toString(),style: TextStyle(fontSize: 16),),
                                      )
                                    ],
                                  ),

                                  if(document['status']!="0")
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left:20,top: 10),
                                            child: Text("Payment Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right:20,top: 10),
                                            child: Text("Payed".toString(),style: TextStyle(fontSize: 16),),
                                          )
                                        ],
                                      ),
                                    ),
                                  if(document['status']!="1")
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left:20,top: 10),
                                            child: Text("Payment Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right:20,top: 10),
                                            child: Text("Not Payed".toString(),style: TextStyle(fontSize: 16),),
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
          )),
    );
  }
}
