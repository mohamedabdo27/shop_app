class CategoryModel {
  bool? status;
  DataModel? dataModel;
  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    dataModel = DataModel.fromJson(json["data"]);
  }
}

class DataModel {
  int? currentPage, from, lastPage, perPage, to, total;
  String? nextPageUrl, firtPageUrl, lastPageUrl, path, prevPageUrl;

  List<Data> data = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json["currentPage"];
    // firtPageUrl = json["first_page_url"];
    // from = json["from"];
    // lastPage = json["last_page"];
    // lastPageUrl = json["last_page_url"];
    // nextPageUrl = json["next_page_url"];
    // path = json["path"];
    // perPage = json["per_page"];
    // prevPageUrl = json["prev_page_url"];
    // to = json["to"];
    // total = json["total"];

    json["data"]!.forEach((element) {
      data.add(
        Data.fromJson(element),
      );
    });
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
