import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mjcars/mycolors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CarForm extends StatefulWidget {
  const CarForm({Key? key}) : super(key: key);

  @override
  State<CarForm> createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> Cars=["Honda", "Suzuki", "Toyota", "Dihatsu"];
  List<String> HondaCars=["Civic",""];
  List<String> SuzukiCars=["Swift",""];
  List<String> ToyotaCars=["Prius",""];
  List<String> DihatsuCars=["Basket",""];
  int _currentStep = 0;
  String Initialvalue="";
  String carType="";
  String carGradeType="";
  String SelectedCarName="";
  final String firstName = "First Name";

  final String lastName = "Last Name";

  final String address = "Address";

  final String phoneNumber = "Phone Number";

  final _formKey = GlobalKey<FormBuilderState>();

  final String carCHOICE = 'carChoice';

  final _form2Key = GlobalKey<FormBuilderState>();

  final String carMake = "CarMake";

  final String carModel = "CarModel";

  final String carName = "CarName";

  final String carColor = "CarColor";

  final String carGrade = "CarGrade";

  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _carColorController = new TextEditingController();
  TextEditingController _carYearController = new TextEditingController();
  bool firstNamerror=false;
  bool lastNamerror=false;
  bool phoneNamerror=false;
  bool emailNamerror=false;
  bool addressNamerror=false;
  bool carMakerror=false;
  bool carNamerror=false;
  bool carcolorerror=false;
  bool carYearerror=false;
  bool carGradeerror=false;
  _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  void Sendqoute(){

    String firstNAme=_firstNameController.text;
    String lastName=_lastNameController.text;
    String phoneNumber=_phoneNumberController.text;
    String address=_addressController.text;
    String carColor=_carColorController.text;
    String carYear=_carYearController.text;

    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    String curretnDate=formattedDate;
    int year=new DateTime.now().year;
    int month=new DateTime.now().month;
    int day=new DateTime.now().day;

    firestore.collection("query").add({
      "firstName":firstNAme,
      "lastName":lastName,
      "Phone":phoneNumber,
      "Email":_auth.currentUser!.email,
      "Address":address,
      "replyPrice":"0",
      "replyStatus":"0",
      "CarName":SelectedCarName,
      "carColors":carColor,
      "carYear":carYear,
      "carType":carType,
      "carGrade":carGradeType,
      "dateNumber":curretnDate,
      "Userseen":"0",
      "Adminseen":"0",
      "adminSeen":"0",
      "date":{
        "year":year,
        "month":month,
        "day":day
      }
    });
    alertshow(context);

  }


  List<Step> steps() => [
        Step(
          title: const Text('Personal info'),
          content: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        onChanged: (val){
                          setState(() {
                            this.firstNamerror=false;
                          });
                        },
                        name: firstName,
                        controller: _firstNameController,

                        decoration: InputDecoration(

                            errorText: this.firstNamerror?"Field can't be Empty":null,
                            suffixIcon: Icon(Icons.person),
                            labelText: 'First Name',
                            labelStyle: this.firstNamerror?TextStyle(color:Colors.red):TextStyle(color:Colors.black54),

                        ),
                        validator: FormBuilderValidators.required(),

                      ),
                      FormBuilderTextField(
                        onChanged: (val){
                          setState(() {
                            this.lastNamerror=false;
                          });
                        },
                        name: lastName,
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          errorText: this.lastNamerror?"Field can't be Empty":null,
                            suffixIcon: Icon(Icons.person), labelText: 'Last Name'),
                        validator: FormBuilderValidators.required(),
                      ),
                      FormBuilderTextField(
                        name: phoneNumber,
                        onChanged: (val){
                          setState(() {
                            this.phoneNamerror=false;
                          });
                        },
                        controller: _phoneNumberController,
                        decoration:  InputDecoration(
                          errorText: this.phoneNamerror?"Field can't be Empty":null,
                            suffixIcon: Icon(Icons.phone), labelText: 'Phone number'),
                        //validator: FormBuilderValidators.numeric(),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autovalidateMode: AutovalidateMode.always,
                      ),

                      FormBuilderTextField(
                        name: address,
                        onChanged: (val){
                          setState(() {
                            this.addressNamerror=false;
                          });
                        },
                        controller: _addressController,
                        decoration:  InputDecoration(
                          errorText: this.addressNamerror?"Field can't be Empty":null,
                            suffixIcon: Icon(Icons.home), labelText: 'Address'),
                        validator: FormBuilderValidators.required(),
                      ),
                    ],
                  )),
            ),
          ),
          state: _stepState(0),
          isActive: _currentStep == 0,
        ),
        Step(
          title: const Text('Card Details'),
          content: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: FormBuilder(
                  key: _form2Key,
                  child: Column(
                    children: [
                      DropdownButtonHideUnderline(
                        child: FormBuilderDropdown(
                          validator: FormBuilderValidators.required(),
                          name: carMake,
                          decoration: InputDecoration(
                              errorText: this.carMakerror?"Field can't be Empty":null,
                              labelStyle: this.carMakerror?TextStyle(color:Colors.red):TextStyle(color:Colors.black54),
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
                      SizedBox(height: 15,),
                      Container(
                        height: 50,
                        child: DecoratedBox(

                          decoration: BoxDecoration(

                            ),
                          child: DropdownButton(
                            // validator: FormBuilderValidators.required(),
                            // name: carMake,
                            // initialValue: Initialv
                            value: Initialvalue,
                            hint: Text("Select Type"),
                            underline: Container(height: 1,color: Colors.black54,),
                            isExpanded: true,
                            onChanged: (val){
                              setState(() {
                                SelectedCarName=val.toString();
                                carNamerror=false;
                                Initialvalue=val.toString();
                                print("Selected Value: "+ SelectedCarName);
                              });
                            },

                            items:
                            carType=="Honda"?HondaCars.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList():
                            carType=="Suzuki"?SuzukiCars.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList():
                            carType=="Toyota"?ToyotaCars.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList():
                            DihatsuCars.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),

                          ),
                        ),
                      ),
                      FormBuilderTextField(
                        name: carColor,
                        onChanged: (val){
                          setState(() {
                            this.carcolorerror=false;
                          });
                        },
                        controller: _carColorController,
                        decoration:  InputDecoration(
                            errorText: this.carcolorerror?"Field can't be Empty":null,
                            labelStyle: this.carcolorerror?TextStyle(color:Colors.red):TextStyle(color:Colors.black54),
                            suffixIcon: Icon(Icons.color_lens),
                            labelText: 'Choose color'),
                        autovalidateMode: AutovalidateMode.always,
                      ),
                      FormBuilderTextField(
                        name: carModel,
                        onChanged: (val){
                          setState(() {
                            this.carYearerror=false;
                          });
                        },
                        controller: _carYearController,
                        decoration:  InputDecoration(
                            errorText: this.carYearerror?"Field can't be Empty":null,
                            labelStyle: this.carYearerror?TextStyle(color:Colors.red):TextStyle(color:Colors.black54),
                            suffixIcon: Icon(Icons.calendar_month),
                            labelText: 'Car year'),
                        validator: FormBuilderValidators.numeric(),
                      ),
                      DropdownButtonHideUnderline(
                        child: FormBuilderDropdown(
                          validator: FormBuilderValidators.required(),
                          name: carGrade,
                          decoration: InputDecoration(
                              errorText: this.carGradeerror?"Field can't be Empty":null,
                              labelText: ("Grade"),
                            labelStyle: this.carGradeerror?TextStyle(color:Colors.red):TextStyle(color:Colors.black54),
                          ),
                          isExpanded: true,
                          onChanged: (val){
                            setState(() {
                              carGradeType=val.toString();
                              carGradeerror=false;
                            });
                          },
                          items: ["4", "3", "2", "1"].map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          state: _stepState(1),
          isActive: _currentStep == 1,
        ),
      ];

  bool checkPersonalBox(){
    String firstNAme=_firstNameController.text;
    String lastName=_lastNameController.text;
    String phoneNumber=_phoneNumberController.text;
    String emailData=_emailController.text;
    String address=_addressController.text;

    if(firstNAme.isEmpty){
      setState(() {
        this.firstNamerror=true;
      });
    }
    else if(lastName.isEmpty){
      setState(() {
        this.lastNamerror=true;
      });
    }
    else if(phoneNumber.isEmpty){
      setState(() {
        this.phoneNamerror=true;
      });
    }


    else if(address.isEmpty){
      setState(() {
        this.addressNamerror=true;
      });
    }
    else{
      return true;
    }
    return false;
  }

  alertshow(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Flutter ALERT",
      desc: "Congragulations",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
  bool checkCarPermission(){

    String carColorData=_carColorController.text;
    String carYearData=_carYearController.text;
    if(carType=="") {
      setState(() {
        this.carMakerror = true;
      });

    }
    if(SelectedCarName==""){
      setState(() {
        this.carNamerror=true;
      });
    }
    else if(carColorData.isEmpty){
      setState(() {
        this.carcolorerror=true;
      });
    }
    else if(carYearData.isEmpty){
      setState(() {
        this.carYearerror=true;
      });
    }
    else if(carGradeType==""){
      setState(() {
        this.carGradeerror=true;
      });

    }

    else{
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    print("asad");
    print(_auth.currentUser!.email);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Import Car"),
          backgroundColor: myColor,
          centerTitle: true,
        ),
        body: Theme(
          data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: myColor,
                ),
          ),
          child: Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: <Widget>[
                    if (_currentStep != 0)
                    ElevatedButton(
                      onPressed: (){
                        bool va=checkCarPermission();
                        //print(val.toString());
                        if(va){
                          print("asad is here");
                          Sendqoute();
                          //Navigator.pop(context);
                        }

                      },
                      child: const Text('Send'),
                    ),
                    if (_currentStep == 0)
                    ElevatedButton(
                      onPressed: (){
                        bool va=checkPersonalBox();
                        print("return value is: "+va.toString());
                        if(va){
                          print("received here");
                          controls.onStepContinue;
                          setState(() {
                            this._currentStep=1;
                          });
                          print("cureent strp: "+_currentStep.toString());
                        }

                    },

                      child: const Text('Next'),
                    ),
                    if (_currentStep != 0)
                      TextButton(

                        onPressed: (){

                        },
                        child: const Text(
                          'BACK',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              );
            },
            onStepTapped: (step) => setState(() => _currentStep = step),
            onStepContinue: () {
              setState(() {
                if (_currentStep < steps().length - 1) {
                  _currentStep += 1;
                } else {
                  _currentStep = 0;
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (_currentStep > 0) {
                  _currentStep -= 1;
                } else {
                  _currentStep = 0;
                }
              });
            },
            currentStep: _currentStep,
            steps: steps(),
          ),
        ),
      ),
    );
  }

  Widget wholeHome(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Import Car Form",
                        style: Theme.of(context).textTheme.headlineSmall)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome to Mj Cars! Please give some details about the car you want to import, and we'll be able to find best match for you.',",
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32,
                  ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: FormBuilder(
                  //         key: _formKey,
                  //         child: Column(
                  //           children: [
                  //             FormBuilderTextField(
                  //               name: firstName,
                  //               decoration: const InputDecoration(labelText: 'First Name'),
                  //               validator: FormBuilderValidators.required(),
                  //             ),
                  //              FormBuilderTextField(
                  //               name: lastName,
                  //               decoration: const InputDecoration(labelText: 'Last Name'),
                  //               validator: FormBuilderValidators.required(),
                  //             ),
                  //              FormBuilderTextField(
                  //               name: phoneNumber,
                  //               decoration: const InputDecoration(labelText: 'Phone number'),
                  //               validator: FormBuilderValidators.numeric(),
                  //               autovalidateMode: AutovalidateMode.always,

                  //             ),
                  //              FormBuilderTextField(
                  //               name: email,
                  //               decoration: const InputDecoration(labelText: 'Email'),
                  //               validator: FormBuilderValidators.email(),
                  //             ),
                  //              FormBuilderTextField(
                  //               name: address,
                  //               decoration: const InputDecoration(labelText: 'Address'),
                  //               validator: FormBuilderValidators.required(),
                  //             ),
                  //              FormBuilderTextField(
                  //               name: firstName,
                  //               decoration: const InputDecoration(labelText: 'First Name'),
                  //               validator: FormBuilderValidators.required(),
                  //             ),
                  //           ],
                  //         )),
                  //   ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddressForm extends StatefulWidget {
  @override
  State<_AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<_AddressForm> {
  //const _AddressForm({Key? key}) : super(key: key);
  final String firstName = "First Name";

  final String lastName = "Last Name";

  final String address = "Address";

  final String email = "Email";

  final String phoneNumber = "Phone Number";

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: firstName,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.person), labelText: 'First Name'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: lastName,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.person), labelText: 'Last Name'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: phoneNumber,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.phone), labelText: 'Phone number'),
                  validator: FormBuilderValidators.numeric(),
                  autovalidateMode: AutovalidateMode.always,
                ),
                FormBuilderTextField(
                  name: email,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.email), labelText: 'Email'),
                  validator: FormBuilderValidators.email(),
                ),
                FormBuilderTextField(
                  name: address,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.home), labelText: 'Address'),
                  validator: FormBuilderValidators.required(),
                ),
              ],
            )),
      ),
    );
  }

  validate() {
    final valid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!valid) {
      showDialog(
          context: context,
          builder: (context) => const SimpleDialog(
                contentPadding: EdgeInsets.all(20),
                title: Text('Please check the form'),
                children: [
                  Text(
                      'Some details are missing or incorrect. Please check the details and try again.')
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          title: const Text("All done!"),
          children: [
            // Text(
            //   "Thanks for all the details! We're going to check your desired  in with the following details.",
            //   style: Theme.of(context).textTheme.caption,
            // ),
            Card(
              child: Column(
                children: [
                  Text(
                      'First name: ${_formKey.currentState!.value[firstName]}'),
                  Text('Last name: ${_formKey.currentState!.value[lastName]}'),
                  Text('Number: ${_formKey.currentState!.value[phoneNumber]}'),
                  Text('email: ${_formKey.currentState!.value[email]}'),
                  Text('address: ${_formKey.currentState!.value[address]}'),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}

class _CardForm extends StatefulWidget {
  @override
  State<_CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<_CardForm> {
  //const _CardForm({Key? key}) : super(key: key);
  //CarMake? _carMake;

  final String carCHOICE = 'carChoice';

  final _form2Key = GlobalKey<FormBuilderState>();

  final String carMake = "CarMake";

  final String carModel = "CarModel";

  final String carName = "CarName";

  final String carColor = "CarColor";

  final String carGrade = "CarGrade";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FormBuilder(
            key: _form2Key,
            child: Column(
              children: [
                DropdownButtonHideUnderline(
                  child: FormBuilderDropdown(
                    validator: FormBuilderValidators.required(),
                    name: carMake,
                    decoration: const InputDecoration(labelText: ("Car Make")),
                    isExpanded: true,
                    items:
                        ["Honda", "Suzuki", "Toyota", "Dihatsu"].map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
                FormBuilderTextField(
                  name: carName,
                  decoration: const InputDecoration(
                      suffixIcon: ImageIcon(AssetImage("assets/body.png")),
                      labelText: 'Car Name'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: carColor,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.color_lens),
                      labelText: 'Choose color'),
                  autovalidateMode: AutovalidateMode.always,
                ),
                FormBuilderTextField(
                  name: carModel,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'Car year'),
                  validator: FormBuilderValidators.numeric(),
                ),
                DropdownButtonHideUnderline(
                  child: FormBuilderDropdown(
                    validator: FormBuilderValidators.required(),
                    name: carGrade,
                    decoration: const InputDecoration(labelText: ("Grade")),
                    isExpanded: true,
                    items: ["4", "3", "2", "1"].map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
