import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';
import 'package:ecommmerce/database/Homemodel.dart';

import 'package:ecommmerce/pages/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BuyNow extends StatefulWidget {
  BuyNow({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  State<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  int changesize = 0;
  var choosesize;
  int choosecolor = 0;
  int count = 1;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => ShopState(),
      child: BlocConsumer<ShopState, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopState app = ShopState();
          return ModalProgressHUD(
            inAsyncCall: loading,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Container(
                  height: height,
                  width: width,
                  child: ListView(
                    children: [
                      Container(
                        height: height * .6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          child: Image.network('${widget.product.image}',
                              fit: BoxFit.cover),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${widget.product.name}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$ ${widget.product.price}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                            allowHalfRating: true,
                            itemSize: 35,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          '${widget.product.desc}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 8,
                          style: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: SizedBox(
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    print(cubit!.loginmodel!.data!.token!);
                                    setState(() {
                                      loading = true;
                                    });
                                    await cubit!.AddToCart(
                                        productId: widget.product.id,
                                        token: cubit!.loginmodel!.data!.token!);
                                    setState(() {
                                      loading = false;
                                    });

                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        desc: 'Added To Cart Successfully',
                                        btnOkOnPress: () {
                                          Navigator.of(context).pop();
                                        })
                                      ..show();
                                  },
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.orange,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)))),
                                )),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SizedBox(
                                  width: 240,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await cubit!.AddToCart(
                                          productId: widget.product.id,
                                          token:
                                              cubit!.loginmodel!.data!.token!);

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Cart()));
                                    },
                                    child: Text(
                                      "Buy Now",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.orange.shade800),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20)))),
                                  )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
