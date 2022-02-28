import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;

  static inti() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json', 'lang': 'en'}));
  }

  static Future<Response> getData({required String url, String? token}) async {
    dio?.options.headers = {'Authorization': token, 'lang': 'en'};
    dynamic result = await dio?.get(url);
    // print('${result}------------------------\n');
    return result;
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      String? token}) async {
    dio?.options.headers = {'Authorization': token, 'lang': 'en'};
    dynamic result = await dio?.post(url, data: data);
    print(result);
    return result;
  }

  static Future<Response> Update(
      {required String url, required Map<String, dynamic> data}) async {
    dynamic ret = await dio?.put(url, data: data);
    print(ret);
    return ret;
  }

  static Future<Response> Delete({required String url, required String token}) {
    dio!.options.headers = {'Authorization': token};
    dynamic ret = dio!.delete(url);
    return ret;
  }
}
