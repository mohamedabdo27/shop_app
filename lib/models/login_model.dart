class LoginModel {
  bool? status;
  String? message;
  LoginDataModel? logindata;
  LoginModel.fromJson(Map<String, dynamic> json) {
    logindata =
        json["data"] == null ? null : LoginDataModel.fromJson(json["data"]);
    status = json["status"];
    message = json["message"];
  }
}

class LoginDataModel {
  String? name, email, phone, token, image;
  int? id;
  int? points, credit;

  LoginDataModel.fromJson(Map<String, dynamic> json) {
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
