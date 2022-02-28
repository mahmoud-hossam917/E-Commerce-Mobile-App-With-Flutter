import 'package:ecommmerce/database/Homemodel.dart';
import 'package:ecommmerce/pages/cart.dart';

class CartInfo {
  bool? status;
  dynamic message;
  CartData? data;
  CartInfo() {
    this.status = false;
  }
  CartInfo.fromjeson({required Map<String, dynamic> jeson}) {
    message = jeson['message'];

    data = (jeson['data'] != null)
        ? CartData.fromjeson(jeson: jeson['data'])
        : null;
    status = (data!.totle != 0) ? jeson['status'] : false;
    print(data!.totle);
  }
}

class CartData {
  dynamic subTotle;
  double? totle = 0;
  List<CartModel> cartItems = [];
  CartData.fromjeson({required Map<String, dynamic> jeson}) {
    subTotle = jeson['sub_total'];

    jeson['cart_items'].forEach((element) {
      CartModel item = CartModel.fromjeson(jeson: element);

      cartItems.add(item);
      totle = totle! + item.product!.price!;
    });
    String tmp = totle!.toStringAsFixed(4);
    totle = double.parse(tmp);
  }
}

class CartModel {
  dynamic id;
  dynamic quantity;
  ProductModel? product;
  bool selectItem = true;
  CartModel.fromjeson({required Map<String, dynamic> jeson}) {
    id = jeson['id'];
    quantity = jeson['quantity'];

    product = ProductModel.fromjeson(jeson: jeson['product']);
  }
}
