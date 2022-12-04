
import 'dart:io';


import 'package:image_picker/image_picker.dart';
class CommonMethodst{
 
  ///****Pick image freom mob Gallery******/
  static Future<File> getImage() async {
    final picker = ImagePicker();
    File _image;
    // ignore: deprecated_member_use
    final image = await picker.getImage(source: ImageSource.gallery);
    //CommonMethodst.imagee=image as Future<File>?;
    _image = File(image!.path);
    return _image;
  }

  ///****Pick image freom mob camera******/
  static Future<File> getCameraImage() async {
    final picker = ImagePicker();
    File _image;
    // ignore: deprecated_member_use
    final image = await picker.getImage(source: ImageSource.camera);
    //StorageFirebaseServices.uploadPstImage(image);
    _image = File(image!.path);
    print(await _image.exists());
  
    return _image;
  }




}