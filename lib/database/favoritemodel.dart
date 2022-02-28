import 'package:ecommmerce/database/Homemodel.dart';

class Favoritemodel {
  bool? status;
  String? message;
  FavoriteData? data;
  Favoritemodel.fromjeson({required Map<String, dynamic> jeson}) {
    status = jeson['status'];
    message = jeson['message'];
    data = jeson['data'] != null
        ? FavoriteData.fromjeson(jeson: jeson['data'])
        : null;
  }
}

class FavoriteData {
  List<ProductModel> items = [];
  FavoriteData.fromjeson({required Map<String, dynamic> jeson}) {
    jeson['data'].forEach((element) {
      ProductModel item = ProductModel.fromjeson(jeson: element['product']);

      items.add(item);
    });
  }
}
