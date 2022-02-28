import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  String? id;
  String? Name;
  String? subname;
  String? desc;
  String? price;
  String? image;
  Product({this.Name, this.subname, this.desc, this.price, this.image});
  void AddProducT() async {
    await FirebaseFirestore.instance.collection('products').add({
      'name': this.Name,
      'subname': this.subname,
      'desc': this.desc,
      'price': this.price,
      'image': this.image
    });
  }

  EditProduct(Product p) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc('${p.id}')
        .update({
      'name': p.Name,
      'subname': p.subname,
      'desc': p.desc,
      'price': p.price,
      'image': p.image,
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> Searchproduct(String name) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .where('name', isEqualTo: name)
        .get();
  }

  DeleteProduct(String ID) async {
    await FirebaseFirestore.instance.collection('products').doc('$ID').delete();
  }
}
