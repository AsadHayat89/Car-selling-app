// ignore_for_file: prefer_const_constructors
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mjcars/dialog.dart';
import 'Admin_Nav.dart';
import 'Textfielddesign.dart';

import 'package:flutter/material.dart';
import 'package:mjcars/mycolors.dart';

class Admin extends StatefulWidget {
  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  var formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  List<PickedFile> ImagesUrl = [];
  String SelectedCarName="";
  bool carMakerror=false;
  String Initialvalue="";
  String carType="";
  List<String> UrlPaths = [];
  List<File> _images = [];
  List<String> Cars=["Honda", "Suzuki", "Toyota", "Dihatsu"];
  final String carMake = "CarMake";
  double val = 0;

  //late String carName,price,carModel;
  TextEditingController carName = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController register = TextEditingController();
  TextEditingController bodyColor = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController carMileage = TextEditingController();
  TextEditingController des = TextEditingController();
  var _image;
  var model;
  var priceTxt;
  var url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 90,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return new Container(
                            height: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                              ), //could change this to Color(0xFF737373),
                              //so you don't have to change MaterialApp canvasColor
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: GestureDetector(
                                    onTap: (){
                                      openCamera("camera");
                                    },
                                      child: Text(
                                    "Camera",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                Center(
                                    child: Container(
                                  width: 300,
                                  height: 1,
                                  color: Colors.black,
                                )),
                                GestureDetector(
                                  onTap: (){
                                    openCamera("gallery");
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Gallery",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                    // File img = await CommonMethodst.getCameraImage();
                    // StorageFirebaseServices.uploadImage(img, "wfrgh");
                    // setState(() {
                    //   openCamera();
                    //   //upload();
                    // });
                  },
                  child: SizedBox(
                      height: 138,
                      width: 256,
                      child: ImagesUrl.isEmpty
                          ? Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.add_a_photo,
                                color: myColor,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: ImagesUrl.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(
                                              File(ImagesUrl[index].path)),
                                        )),
                                        height: 58,
                                        width: 110,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return new Container(
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20.0),
                                                topLeft: Radius.circular(20.0),
                                              ), //could change this to Color(0xFF737373),
                                              //so you don't have to change MaterialApp canvasColor
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                                  child: GestureDetector(
                                                      onTap: (){
                                                        openCamera("camera");
                                                      },
                                                      child: Text(
                                                        "Camera",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                ),
                                                Center(
                                                    child: Container(
                                                      width: 300,
                                                      height: 1,
                                                      color: Colors.black,
                                                    )),
                                                GestureDetector(
                                                  onTap: (){
                                                    openCamera("gallery");
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 10),
                                                    child: Text(
                                                      "Gallery",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    color: myColor,
                                    height: 30,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          size: 19,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "Add more Images",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  children: [

                    DropdownButtonHideUnderline(
                      child: FormBuilderDropdown(
                        validator: FormBuilderValidators.required(),
                        name: carMake,
                        decoration: InputDecoration(
                            // errorText: this.carMakerror?"Field can't be Empty":null,
                            // labelStyle: this.carMakerror?TextStyle(color:Colors.red):TextStyle(color:Colors.black54),
                            labelText: ("Car Make")
                        ),
                        isExpanded: true,

                        onChanged: (val){
                          setState(() {
                            SelectedCarName="";
                            carType=val.toString();
                            carMakerror=false;
                            Initialvalue="";
                          });
                        },
                        items:
                        Cars.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    l("body", "Car Name", carName),
                    SizedBox(
                      height: 25,
                    ),
                    l("regist", "Register in", register),
                    SizedBox(
                      height: 25,
                    ),
                    l("color", "Body color", bodyColor),
                    SizedBox(
                      height: 25,
                    ),
                    l("price", "Price", price),
                    SizedBox(
                      height: 25,
                    ),
                    l("mileage", "Mileage(km)", carMileage),
                    SizedBox(
                      height: 25,
                    ),
                    l("descrip", "Description", des),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 20,
                          shadowColor: myColor,
                          primary: myColor),
                      child: Text('Add car'),
                      onPressed: () {
                        uploadFile();

                        //_image=null;

                        // AuthServices.add_car_data( {
                        //    "car_model":carModel.text,
                        //    "body_color":_bdclrcontroller.text,
                        //    "price":price.text,
                        //    "mil":_milcontroller.text,
                        //    "Registeredin":_regmcontroller.text,
                        //    "des":_desontroller.text,

                        // })
                        // ;
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> openCamera(String data) async {
    final pickedFile;
    if(data=="gallery"){
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }
    else{
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }

    File selected = File(pickedFile!.path);

    setState(() {
      print("selected files: "+selected.path.toString());
      _images.add(selected);
      ImagesUrl.add(pickedFile);
      print("selected files: "+pickedFile.path.toString());
      print(ImagesUrl.length.toString());
    });
  }

  Future uploadFile() async {
    //int j = 1;

    try {
      showAlertDialog(context);
      print("here 1");
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("TesFolder/${DateTime.now()}");
      for (int i = 0; i < ImagesUrl.length; i++) {
        print("data here: "+ImagesUrl[i].path.toString());
        await ref.putFile(File(ImagesUrl[i]!.path));
        var imageUrl = await ref.getDownloadURL();
        print("data here: " + imageUrl);
        //url = imageUrl.toString();
        setState(() {
          print("data found here 1");
          UrlPaths.add(imageUrl);

        });
      }
    } on Exception {}

    setState(() {
      print("paths here: " + UrlPaths[0].toString());
      DatabaseReference refi = FirebaseDatabase.instance.ref("user");
      refi.push().set({
        'mil': carMileage.text,
        'carName': carName.text,
        'model': carType,
        'RegisteredIn': register.text,
        'price': price.text,
        'imgUrl': UrlPaths,
        "body_color": bodyColor.text,
        "description": des.text,
      });

      carModel.clear();
      price.clear();
      carName.clear();
      carMileage.clear();
      bodyColor.clear();
      des.clear();
      register.clear();
      _image = null;
    });

    Navigator.of(context, rootNavigator: false)
        .push(MaterialPageRoute(builder: (context) => NavBar()));
  }

  Future<void> upload() async {
    if (formKey.currentState!.validate()) {
      //var storageref = _storage.ref("TesFolder/${getImageName(_image)}");
      //var a = File(_image!.path);
      // UploadTask task = storageref.putFile(a);

      try {
        showAlertDialog(context);
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("TesFolder/${DateTime.now()}");
        for (int i = 0; i < ImagesUrl.length; i++) {
          await ref.putFile(File(ImagesUrl[i]!.path));
          var imageUrl = await ref.getDownloadURL();
          print("data here: " + imageUrl);
          //url = imageUrl.toString();
          setState(() {
            UrlPaths.add(imageUrl);
          });
        }

        //print(imageUrl);
        print("completed url");
        Navigator.pop(context);
      } on Exception {
        // TODO
      }

      setState(() {
        print("recehd");
        DatabaseReference refi = FirebaseDatabase.instance.ref("user");
        refi.push().set({
          'mil': carMileage.text,
          'carName': carName.text,
          'model': carModel.text,
          'RegisteredIn': register.text,
          'price': price.text,
          'imgUrl': UrlPaths,
          "body_color": bodyColor.text,
          "description": des.text,
        });

        carModel.clear();
        price.clear();
        carName.clear();
        carMileage.clear();
        bodyColor.clear();
        des.clear();
        register.clear();
        _image = null;
      });

      //map["carName"]=carName;

      // databaseReference.child(uploadId!).set(map);
    }
  }

  String getImageName(var image) {
    return image.path.split("/").last;
  }
}
