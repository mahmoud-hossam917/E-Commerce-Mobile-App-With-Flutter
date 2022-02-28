import 'package:ecommmerce/database/Homemodel.dart';

class SearchModel {
  bool? status;
  String? message;
  SearchData? data;
  SearchModel.fromjeson({required Map<String, dynamic> jeson}) {
    message = jeson['message'];
    data = SearchData.fromjeson(jeson: jeson['data']);
    status = (data!.products.length > 0) ? jeson['status'] : false;
  }
}

class SearchData {
  List<ProductModel> products = [];

  SearchData.fromjeson({required Map<String, dynamic> jeson}) {
    jeson['data'].forEach((element) {
      ProductModel item = ProductModel.fromjeson(jeson: element);
      products.add(item);
    });
  }
}
