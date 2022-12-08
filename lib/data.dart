import 'dart:core';

class Data 
{
  String? carName;
  List<Object?> url;
  String?price;
  String?uploadId;
  String? address;
  String? body_color;
  String? description;
String? mil;
String? model;
  Data( this.carName , this. price, this.url,this.uploadId,this.address,this.body_color,this.description,this.mil,this.model);
    
    
  //   // this.carModel;
  //   // this.carMileage;
  //   // this.bodyColor;
  //   // this.des;
  //   // this.register;



  
   
   get CarName {
    return carName;
}

  set CarName( var carName) {
   this.carName = carName;
}


get Price {
    return price;
}
set Price(var price) {
    this.price = price;
 }


 get Url {
    return url;
}

 set Url(var url) {
    this.url = url;
   
 }

get Uploadid
{
  return uploadId;
}
 set Uploadid(var uploadId)
 {
  this.uploadId=uploadId;
 }
 
}

  

//,var carModel,var carMileage,var bodyColor,var des,var register  ,carModel,carMileage,bodyColor,des,register;