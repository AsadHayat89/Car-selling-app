import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageFirebaseServices {


  ///****upload account pic on firebase Storage******/
  static Future<String> uploadImage(_image, email,) async {
    try{
    var imagestatus = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child(email+".jpg")
        .putFile(_image) //await StorageFirebaseServices.getImage())
        .then((value) => value);
    String imageUrl = await imagestatus.ref.getDownloadURL();
    return imageUrl;}
    catch(e){print (e);}
    return "s";
  }


}
