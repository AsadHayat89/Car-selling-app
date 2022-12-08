
class Userdata {
  final String ID;
  final String email;
  final String type;

  Userdata({required this.ID, required this.email, required this.type});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user["ID"] = ID;
    user["email"] = this.email;
    user["type"] = this.type;
    return user;
  }
  factory Userdata.fromJson(Map<String,dynamic> json){
    return Userdata(
      ID: json['ID'],
      email: json['email'],
      type: json['type'],

    );
  }
}