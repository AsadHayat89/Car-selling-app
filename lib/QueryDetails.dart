import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'mycolors.dart';
class QueryDetail extends StatefulWidget {
  String DetailId;
  QueryDetail({Key? key,required this.DetailId}) : super(key: key);

  @override
  State<QueryDetail> createState() => _QueryDetailState();
}

class _QueryDetailState extends State<QueryDetail> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String email="";
  String errorText="";
  bool errorfound=false;
  String phone="";
  String address="";
  String carType="";
  String carYear="";
  String carcolor="";
  String PredictedPrice="";
  String carGrade="";
  String carName="";

  TextEditingController mycontroller = TextEditingController();

  void getDetails(String id) async{
    var docSnapshot = await firestore.collection('query').doc(widget.DetailId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      setState((){
        phone = data?['Phone'];
        email= data?['Email'];
        address=data?['Address'];
        carType=data?['carType'];
        carYear=data?['carYear'];
        carcolor=data?['carColors'];
        carGrade=data?['carGrade'];
        carName=data?['CarName'];
      });

      //print("Value:  "+value.toString());// <-- The value you want to retrieve.
      // Call setState if needed.
    }
  }

  Future<bool> updatedata() async{
    await firestore.collection('query').doc(widget.DetailId).update({
      "replyPrice":mycontroller.text,
      "replyStatus":"1",
    }).then((result){
      print("new USer true");
      return true;
    }).catchError((onError){
      print("onError");
      return false;
    });
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getDetails(widget.DetailId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top:60,left:30,right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text("Details",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: myColor),)),
                Padding(
                  padding:  EdgeInsets.only(top: 50),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person,color: myColor,size: 38,),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Car Name",style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(this.carName,style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person,color: myColor,size: 38,),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Email",style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(this.email,style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.contact_page,color: myColor,size: 38,),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Address",style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(this.address,style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.phone,color: myColor,size: 38,),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Phone",style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(this.phone,style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.car_rental,color: myColor,size: 38,),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Car Type",style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(this.carType,style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_month,color: myColor,size: 38,),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Car Year",style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(this.carYear,style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.color_lens_outlined,color: myColor,size: 38,),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Car Color",style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(this.carcolor,style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.color_lens_outlined,color: myColor,size: 38,),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Car Grade",style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(this.carGrade,style: TextStyle(fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("Predicted Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: myColor),),
                      ),

                      TextField(

                        controller: mycontroller,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          errorText: errorText,
                          border: OutlineInputBorder(),
                          labelText: 'Price',
                          hintText: 'Enter Price',
                          labelStyle: TextStyle(color: myColor)
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 50,bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: (){
                            if(mycontroller.text.isEmpty){
                              setState(() {
                                this.errorfound=true;
                                this.errorText="Price cant be empty";
                              });

                            }
                            Future<bool> res=updatedata();
                          Navigator.pop(context);
                          },
                          child: Container(
                            width: 100,
                            height: 40,

                            decoration: BoxDecoration(
                              color: myColor,
                                border: Border.all(
                                  color: myColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Center(child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 18),)),
                          ),
                        ),
                      ),
                  Container(
                    width: 100,
                    height: 40,

                    decoration: BoxDecoration(
                        border: Border.all(
                          color: myColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(child: Text("Back",style: TextStyle(fontSize: 18),)),
                  ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
