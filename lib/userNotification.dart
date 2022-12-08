import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mjcars/payment/payment.dart';
import 'package:mjcars/uerQueryDetail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'Controller/adminController.dart';
import 'QueryDetails.dart';
import 'agreementPdf.dart';
import 'model/query.dart';
import 'mycolors.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({Key? key}) : super(key: key);

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  Map<String, dynamic>? paymentIntent;
  bool? valuefirst = false;
  var Controllervale=Get.put(AdminController());
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String curretnDate="";
  void getDate(){
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    curretnDate=formattedDate;
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
    getDetails();
    UserSeenData();
  }
  void UserSeenData() async{
    // var doc;
    // var snapshot = await firestore.collection('query').get();
    // snapshot.docs.map(doc => doc.data());
  }
  void getDetails() async{

    await firestore.collection("query")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        //Needs obj= new Need();
        //print("seen data:"+f['Userseen']);
        firestore.collection("query").doc(f.id).update({"Userseen":"1"});

      });
        }
    );
    setState(() {
        Controllervale.notify.value=false;
        Controllervale.notifyValue.value=0;
        print("came here");
      });



  }

  @override
  Widget build(BuildContext context) {


    Stream<QuerySnapshot> cropsStream =  firestore.collection("query").where('Email',isEqualTo:FirebaseAuth.instance.currentUser?.email).orderBy("dateNumber",descending: false).snapshots();
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey.shade300,
        child: StreamBuilder(
          stream: firestore.collection("query").where('Email',isEqualTo:FirebaseAuth.instance.currentUser?.email).snapshots(),
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
                child: Text('Loadings...'),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Container(
                alignment: Alignment.center,
                child: Text('No Query avaiable'),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document){
                return Padding(
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                  child: GestureDetector(
                    onTap: (){
                      //print("Document id: "+document.id);
                      if(document['replyStatus']=="1"){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserQueryDetail(DetailId:document.id,)));
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
                                if(document['replyStatus']!="0")
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left:20,top: 10),
                                      child: Text("Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right:20,top: 10),
                                      child: Text(document['replyPrice'].toString(),style: TextStyle(fontSize: 16),),
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
                                        child: Text(document['replyStatus']=="0"?"pending":"Reveied"),
                                      )
                                    ],
                                  ),
                                ),
                                if(document['replyStatus']!="0")
                                  Padding(
                                    padding:EdgeInsets.only(bottom: 10),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10,bottom: 5),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left:20,bottom: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                  checkColor: Colors.greenAccent,
                                                  activeColor: myColor,

                                                  value: this.valuefirst,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      this.valuefirst = value;
                                                    });
                                                  },
                                                ),
                                                GestureDetector(onTap: (){Get.to(agreementPDF());},
                                                    child: Text("Click here to see",style: TextStyle(color: myColor),)),
                                                GestureDetector(onTap: (){Get.to(agreementPDF());},
                                                    child: Text(" Agrement",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                                              ],
                                            ),
                                          ),
                                          if(valuefirst==true)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: 10),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    print("Print Id for data :"+document.id);
                                                    deleteData(document.id);
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 40,
                                                    decoration: new BoxDecoration(

                                                        border: Border.all(color: myColor),
                                                      borderRadius: new BorderRadius.all(Radius.circular(20)),
                                                    ),
                                                    child: Center(child: Text("Decline",style: TextStyle(color: myColor,fontSize: 18),)),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  if(valuefirst==true){
                                                    int price=int.parse(document['replyPrice']);
                                                    int percent=((price/100)*20).toInt();
                                                    int totalPrice=price-percent;
                                                    makePayment(percent.toString(),document.id);
                                                  }

                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 40,
                                                  decoration: new BoxDecoration(
                                                    color: myColor,
                                                    border: Border.all(color: myColor),
                                                    borderRadius: new BorderRadius.all(Radius.circular(20)),
                                                  ),
                                                  child: Center(child: Text("Accept",style: TextStyle(color: Colors.white,fontSize: 18),)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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

  Future<void> makePayment(String ammount,String qID) async {
    try {
      paymentIntent = await createPaymentIntent(ammount, 'PKR');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan'))
          .then((value) {

      });

      ///now finally display payment sheeet

      displayPaymentSheet();
      addpaymentdetail(ammount,"1");
      deleteData(qID);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }
  void deleteData(String qID){
    FirebaseFirestore.instance.collection("query").doc(qID).delete();
  }

 void addpaymentdetail(String ammount,String sat){

    FirebaseFirestore.instance
       .collection('payment')
       .add(
        {'User': FirebaseAuth.instance.currentUser?.email.toString(),
          'Ammount':ammount,
          'date':this.curretnDate,
          'status':sat
        }
    );
 }
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text("Payment Successfull"),
                    ],
                  ),
                ],
              ),
            ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
          'Bearer sk_test_51M2TlrIyZcrUZatMeCCJJ2zu71hW6xXnmIxph9jkUMXsbaS95fU17u5yTQsbspJZFf9EFjxBR93ZxMFOyStaY2EL00THiX7PAQ',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
