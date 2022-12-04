import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class AdminController extends GetxController{
  RxList<PickedFile> imageList=RxList<PickedFile>().obs();
  RxBool notify=false.obs;
  RxInt notifyValue=0.obs;
  RxBool Adminnotify=false.obs;
  RxInt AdminnotifyValue=0.obs;
  Future<void> openCamera() async {
    PickedFile? _image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    imageList.value.add(_image!);
  }

}