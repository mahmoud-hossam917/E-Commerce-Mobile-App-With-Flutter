import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/componts/mybotton.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';

import 'package:ecommmerce/pages/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  Cart({
    Key? key,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool cur = true;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopState>(create: (context) {
          return ShopState()..GetCart(token: cubit!.loginmodel!.data!.token!);
        })
      ],
      child: BlocConsumer<ShopState, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit!.myCart = ShopState.get(context).myCart;
          ShopState app = ShopState.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.orange,
              title: Center(
                  child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'Cart',
                  style: TextStyle(color: Colors.white),
                ),
              )),
              toolbarHeight: 80,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ))
              ],
            ),
            body: ConditionalBuilder(
                condition: state is! LoadingCart,
                builder: (context) => Card(
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * .6,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: (cubit!.myCart!.status == true)
                                ? cubit!.myCart!.data!.cartItems.length
                                : 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 5),
                                child: Container(
                                  height: 100,
                                  child: ListTile(
                                    leading: Container(
                                      height: 100,
                                      width: 100,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  value: cubit!
                                                      .myCart!
                                                      .data!
                                                      .cartItems[index]
                                                      .selectItem,
                                                  onChanged: (val) {
                                                    app.SelectItem(index);
                                                  }),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                  height: 50,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      child: Image.network(
                                                        cubit!
                                                            .myCart!
                                                            .data!
                                                            .cartItems[index]
                                                            .product!
                                                            .image,
                                                        fit: BoxFit.cover,
                                                      ))),
                                            ),
                                          ]),
                                    ),
                                    title: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit!.myCart!.data!
                                                .cartItems[index].product!.name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                          ),
                                          Text(
                                            '${cubit!.myCart!.data!.cartItems[index].product!.price}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style:
                                                TextStyle(color: Colors.orange),
                                          )
                                        ],
                                      ),
                                    ),
                                    trailing: Expanded(
                                      child: Container(
                                        width: 110,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    app.minus(index);
                                                  },
                                                  icon: Icon(
                                                    Icons.remove,
                                                    color: Colors.black,
                                                  )),
                                              Text(
                                                '${cubit!.myCart!.data!.cartItems[index].quantity}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    app.plus(index);
                                                  },
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    )),
            bottomSheet: Card(
              child: Container(
                height: MediaQuery.of(context).size.height * .225,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select all',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                          value: cur,
                          onChanged: (val) {
                            setState(() {
                              cur = !cur;
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Totle Payment',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (state is! LoadingCart &&
                                    cubit!.myCart!.status == true)
                                ? Text(
                                    '${cubit!.myCart!.data!.totle}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        color: Colors.orange),
                                  )
                                : Text('0.0',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        color: Colors.orange))),
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          (cubit!.myCart!.status == true)
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Adress()))
                              : null;
                        },
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                (cubit!.myCart!.status == true)
                                    ? Colors.orange[800]
                                    : Colors.grey[400]),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
