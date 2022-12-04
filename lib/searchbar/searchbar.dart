import 'package:flutter/material.dart';
import 'package:mjcars/home.dart';
import 'package:sizer/sizer.dart';

search(BuildContext context, Function search) {
  return Container(
    width: 90.w,

    //height:  MediaQuery.of(context).size.height,

    margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
    child: Column(
      children: [
        Row(
          children: [
            Flexible(
              //flex: 1,
              child: TextField(
                onChanged: ((text) {
                  search(text);
                }),
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Search',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(15),
                      width: 18,
                      child: Image.asset('assets/search.png'),
                    )),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
