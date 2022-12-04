import 'package:flutter/material.dart';
import 'mycolors.dart';

class Textfielddesign{
  
}  

TextField l(String s,String hint,var con) {
  
  return TextField(
    
    controller: con,
    decoration: InputDecoration(
      prefixIcon: ImageIcon(
        AssetImage("assets/$s.png"),
        color: myColor,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    hintText: hint),
    
  );
}
