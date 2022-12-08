import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjcars/mycolors.dart';

import '../Admin_Nav.dart';
import '../data.dart';


class AdminDetailPage extends StatefulWidget {
  var pic, des;
  List<Object?> dataList = [];
  Data? u;

  AdminDetailPage(var pic, var des, List<Object?> data, Data u1) {
    this.pic = pic;
    this.des = des;
    this.dataList = data;
    this.u = u1;
    print("Pices sicze : " + pic);
  }

  @override
  State<AdminDetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<AdminDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("data size: " + widget.dataList.length.toString());
    for (int i = 0; i < widget.dataList.length; i++) {
      print(widget.dataList[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${widget.pic}"),
                fit: BoxFit.fitWidth,
              ),
            )),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      "${widget.des}",
      style: const TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () => {},
          style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(myColor)),
          child:
          const Text("Contact us", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PKR " + widget.u!.price.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                widget.u!.price.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Register In",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                Text(widget.u!.address.toString(),style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
          Center(child: Container(width: 300,height: 1,color: Colors.grey,)),
          Padding(
            padding: EdgeInsets.only(top: 15,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Color",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                Text(widget.u!.body_color.toString(),style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
          Center(child: Container(width: 300,height: 1,color: Colors.grey,)),
          Padding(
            padding: EdgeInsets.only(top: 15,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Car Name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                Text(widget.u!.carName.toString(),style: TextStyle(fontSize: 18),),
              ],
            ),
          ),

          Center(child: Container(width: 300,height: 1,color: Colors.grey,)),
          Padding(
            padding: EdgeInsets.only(top: 15,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mill",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                Text(widget.u!.mil.toString(),style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
          Center(child: Container(width: 300,height: 1,color: Colors.grey,)),
          Center(child: Container(width: 300,height: 1,color: Colors.grey,)),
          Padding(
            padding: EdgeInsets.only(top: 15,bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(widget.u!.description.toString(),style: TextStyle(fontSize: 18),),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20,bottom: 10),
            child: Center(
              child: GestureDetector(
                onTap: (){
                  print(widget.u!.uploadId.toString());
                  FirebaseDatabase.instance.reference()
                      .child('user')
                      .child(widget.u!.uploadId.toString())
                      .remove();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavBar()));


                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: myColor,
                      border: Border.all(
                        color: myColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Center(child: Text("Delete",style: TextStyle(fontSize: 24,color: Colors.white),)),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              itemCount: widget.dataList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${widget.dataList[itemIndex]}"),
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                  ),
            ),
            bottomContent
          ],
        ),
      ),
    );
  }
}
