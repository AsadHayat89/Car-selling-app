import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mjcars/mycolors.dart';

showAlertDialog(BuildContext context) {
  final spinkit = SpinKitThreeBounce(
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

  // AlertDialog alert=AlertDialog(

  //   content: Row(
  //       children: [
  //          const CircularProgressIndicator(),
  //          Container(margin: const EdgeInsets.only(left: 5),child: Text(txt)),
  //       ],),
  // );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
    
      return spinkit;
    },
  );
}

