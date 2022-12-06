
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mjcars/mycolors.dart';

import 'data.dart';

class DetailPage extends StatefulWidget {
  var pic, des;
  List<Object?> dataList = [];
  DetailPage(var pic, var des, List<Object?> data) {
    this.pic = pic;
    this.des = des;
    this.dataList=data;
    print("Pices sicze : "+pic);
  }

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("data size: "+widget.dataList.length.toString());
    for(int i=0;i<widget.dataList.length;i++){
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
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(myColor)),
          child: const Text("Contact us", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16/9,
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
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
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
          bottomContent],
      ),
    );
  }
}
