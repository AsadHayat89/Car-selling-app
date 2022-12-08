import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mjcars/mycolors.dart';
class Certificate extends StatefulWidget {
  String useremail;
  String pay;
   Certificate({Key? key,required this.useremail,required this.pay}) : super(key: key);

  @override
  State<Certificate> createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  String datatoday="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    datatoday=formattedDate;
    print(formattedDate);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: Center(
              child:Text("Payment Receipt",style: TextStyle(color: myColor,fontSize: 28,fontWeight: FontWeight.bold),) ,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child:Text("The ${widget.useremail}\nhave payed rupees the ammount\n of ${widget.pay}",style: TextStyle(color: Colors.black,fontSize: 20,height: 1.5),) ,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 45,left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(datatoday),
                        ),
                        Container(width: 110,height: 1,color: Colors.black,),
                        Text("Date")
                      ],
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text("Mjcars"),
                      ),
                      Container(width: 110,height: 1,color: Colors.black,),
                      Text("Company Signed")
                    ],
                  )
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
