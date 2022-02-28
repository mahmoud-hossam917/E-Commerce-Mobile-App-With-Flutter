import 'package:flutter/cupertino.dart';

class HomeModel {
  var status;
  var message;
  HomeDataModel? data;
  HomeModel.fromjeson({required Map<String, dynamic> jeson}) {
    status = jeson['status'];

    message = jeson['message'];

    data = HomeDataModel.fromjeson(jeson: jeson['data']);
  }
}

class HomeDataModel {
  List<ProductModel> products = [];
  HomeDataModel.fromjeson({required Map<String, dynamic> jeson}) {
    jeson['products'].forEach((Element) {
      ProductModel model = ProductModel.fromjeson(jeson: Element);
      products.add(model);
    });
  }
}

class ProductModel {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  dynamic image;
  bool? inFavorites;
  dynamic inCart;
  dynamic name;
  dynamic desc;
  ProductModel.fromjeson({required Map<String, dynamic> jeson}) {
    id = jeson['id'];
    price = jeson['price'];
    oldPrice = jeson['old_price'];
    discount = jeson['discount'];
    image = jeson['image'];
    inFavorites = jeson['in_favorites'];
    inCart = jeson['in_cart'];
    name = jeson['name'];
    desc = jeson['description'];
  }
}
