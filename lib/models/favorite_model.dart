class FavoriteModel {
  bool? status;
  String? message;
  DataModel? data;
  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = DataModel.fromJson(json["data"]);
  }
}

class DataModel {
  int? currentPage;
  List<Data> data = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"]!.forEach((element) => {
          data.add(Data.fromJson(element)),
        });
  }
}

class Data {
  int? id;
  FavoriteProductData? favoriteProductData;
  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    favoriteProductData = FavoriteProductData.fromJson(json["product"]);
  }
}

class FavoriteProductData {
  int? id, discount;
  dynamic oldPrice, price;
  String? name, image, description;
  FavoriteProductData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    description = json["description"];
    image = json["image"];
    name = json["name"];
    discount = json["discount"];
  }
}

//////////////////////////////////////////////////////////////////////////////////////////
// class FavoriteModel {
//   bool? status;
//   String? message;
//   DataModel? data;

//   FavoriteModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
//   }
// }

// class DataModel {
//   int? currentPage;
//   List<Data>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   String? prevPageUrl;
//   int? to;
//   int? total;

//   DataModel.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
// }

// class Data {
//   int? id;
//   Product? product;

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product =
//         json['product'] != null ? Product.fromJson(json['product']) : null;
//   }
// }

// class Product {
//   int? id;
//   double? price;
//   double? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;

//   Product(
//       {this.id,
//       this.price,
//       this.oldPrice,
//       this.discount,
//       this.image,
//       this.name,
//       this.description});

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
// }
