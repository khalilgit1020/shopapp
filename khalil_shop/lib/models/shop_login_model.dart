class ShopLoginModel {
    bool? status;
    String? message;
    UserData? data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null) ;
  }
}

class UserData {
  late final  int? id;
  late final String name;
  late final String email;
  late final String phone;
  late final String image;
  late final int? points;
  late final int? credit;
  late String token;


 // named constructor

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
