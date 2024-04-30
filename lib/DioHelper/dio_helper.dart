import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        // headers: {
        //   "Content-Type": "application/json",
        // }
      ),
    );
  }
//-------------------------------------------------------

  static Future<Response> get({
    String lang = "en",
    String? token,
    Map<String, dynamic>? query,
    required String url,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token,
      "Content-Type": "application/json",
    };
    return await dio.get(url, queryParameters: query);
  }

//*******************************************************
  static Future<Response> post({
    required String url,
    String lang = "en",
    String? token,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token,
      "Content-Type": "application/json",
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  //==============================================================
  static Future<Response> put({
    required String url,
    String lang = "en",
    String? token,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token,
      "Content-Type": "application/json",
    };

    return await dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
