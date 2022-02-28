import 'package:flutter/material.dart';

class loginModel {
  bool? status;
  String? message;
  userData? data;
  loginModel() {
    this.status = false;
  }
  loginModel.formjeson({required Map<String, dynamic> jeson}) {
    status = jeson['status'];

    message = jeson['message'];

    data = (jeson['data'] != null)
        ? userData.fromjeson(jeson: jeson['data'])
        : null;
  }
}

class userData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points, credit;
  String? token;
  String? password;
  userData.fromjeson({required Map<String, dynamic> jeson}) {
    id = jeson['id'];
    email = jeson['email'];
    name = jeson['name'];
    phone = jeson['phone'];
    image = jeson['image'];
    points = jeson['points'];
    credit = jeson['credit'];
    token = jeson['token'];
  }
}
