import 'dart:developer';

class SearchModel {
  bool? status;
  String? message;
  DataModel? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : DataModel.fromJson(json["data"]);
  }
}

class DataModel {
  List<Data> data = [];
  int? currentPage;
  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"]!.forEach((element) => {
          data.add(Data.fromJson(element)),
        });
  }
}

class Data {
  int? id;
  dynamic price;
  String? image, name, description;
  bool? inFavorite, inCart;
  //List<String> images = [];
  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    image = json["image"];
    name = json["name"];
    description = json["description"];
    inFavorite = json["in_favorites"];
    inCart = json["in_cart"];
    // json["images"].forEach((element) {
    //   images.add(element);
    // });
  }
}
