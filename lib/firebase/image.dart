import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:mjcars/admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// class Upload extends StatefulWidget {
//   const Upload({Key? key}) : super(key: key);

  

//   @override
//   State<Upload> createState() => _UploadState();
// }

// class _UploadState extends State<Upload> {
//   @override
//   Widget build(BuildContext context) {
    
   
//     late File a;
//   late var task;
//   late var imageFile;
//   Admin admin=Admin();
  

//   Future<void> url()async{
//     Reference reference=FirebaseStorage.instance.ref().child("image").child(new DateTime.now().millisecondsSinceEpoch.toString()+"."+imageFile.path);
//     UploadTask uploadTask=reference.putFile(imageFile);

//     // if(admin.formKey.currentState!.validate())
//     // {
      
//     //   FirebaseStorage storage = FirebaseStorage.instance;
//     // Reference ref = storage.ref().child("images" + DateTime.now().toString()+"."+a.path);
//     // await ref.putFile(File(task.path));
//     // String imageUrl = await ref.getDownloadURL();
//     // String url=imageUrl.toString();
//     // print(url);
//     // }
//   }
//      return Container();
//   }
  
// }

  

