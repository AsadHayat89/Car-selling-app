import 'package:get/get.dart';

class Querydata {
  String? address;
  String? CarName;
  String? Email; // verified=>green, pending=>yellow, rejected=>red,
  String? Phone;
  String? carColors;
  String? carGrade;
  String? carType;
  String? carYear;
  String? firstName;
  String? replyPrice;
  String? replyStatus;
  String? lastName;

  Querydata(
      {this.carYear, this.lastName, this.replyPrice, this.replyStatus,
        this.firstName, this.carType, this.carGrade, this.carColors,
        this.Phone, this.Email, this.CarName, this.address, });

  factory Querydata.fromJson(Map<String,dynamic> json){
    return Querydata(
      carYear: json['carYear'],
      lastName: json['lastName'],
      replyPrice: json['replyPrice'],
      replyStatus: json['replyStatus'],
      firstName: json['firstName'],
      carType: json['carType'],
      carGrade: json['carGrade'],
      carColors: json['carColors'],
      Phone: json['Phone'],
      Email: json['Email'],
      CarName: json['CarName'],
      address: json['address'],
    );
  }
}
