class HomeModel {
  HomeModel({
    required this.status,
    required this.data,
  });

  bool? status;
  DataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = DataModel.fromJson(
      json["data"],
    );
  }
}

class DataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    json["banners"]!.forEach((element) {
      banners.add(BannersModel.fromjson(element));
    });

    json["products"]!.forEach((element) {
      products.add(ProductsModel.fromjson(element));
    });
  }
}

class BannersModel {
  int? id;
  String? image;
  BannersModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}

class ProductsModel {
  int? id;
  dynamic price, oldPrice, discoung;
  String? image, name;
  bool? inFavorite, inCart;

  ProductsModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    price = json["price"];
    oldPrice = json["old_price"];
    name = json["name"];
    discoung = json["discount"];
    inFavorite = json["in_favorites"];
    inCart = json["in_cart"];
  }
}
