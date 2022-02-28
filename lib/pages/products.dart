import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';
import 'package:ecommmerce/database/modelproduct.dart';

import 'package:ecommmerce/pages/buynow.dart';
import 'package:ecommmerce/pages/editproduct.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Products extends StatefulWidget {
  Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  int chagetype = 0;

  changepage(int index, String NameItem) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          setState(() {
            chagetype = index;
          });
        },
        child: AnimatedContainer(
          duration: Duration(microseconds: 500),
          height: 30,
          width: (chagetype == index) ? 100 : 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (chagetype == index) ? Colors.orange : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              '${NameItem}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool favorite = false;
  List banners = ['All', 'Catagory', 'Clothes', 'Sports', 'Food'];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopState()..HomeProducts(token: cubit!.loginmodel!.data!.token!),
      child: BlocConsumer<ShopState, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit?.homemodel = ShopState.get(context).homemodel;
          ShopState app = ShopState.get(context);
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        5, (index) => changepage(index, banners[index]))),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 250,
                width: MediaQuery.of(context).size.width,
                child: ConditionalBuilder(
                    condition: state is! ProductsLoading,
                    builder: (context) {
                      return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: .65),
                        itemCount: cubit?.homemodel?.data?.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(children: <Widget>[
                                Stack(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      child: Container(
                                        height: 150,
                                        width: 170,
                                        child: Image.network(
                                          '${cubit?.homemodel?.data?.products[index].image}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () async {
                                              app.ChangeFavorite(index, false);

                                              await app.AddToFavorite(
                                                  productID: cubit!
                                                      .homemodel!
                                                      .data!
                                                      .products[index]
                                                      .id);

                                              print(cubit!
                                                  .loginmodel!.data!.token);
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              color: (cubit!
                                                          .homemodel!
                                                          .data!
                                                          .products[index]
                                                          .inFavorites ==
                                                      true)
                                                  ? Colors.red
                                                  : Colors.grey[350],
                                            )))
                                  ],
                                ),
                                Card(
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${cubit?.homemodel?.data?.products[index].name}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  '\$ ${cubit?.homemodel?.data?.products[index].price}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                ),
                                              ],
                                            )),
                                        Spacer(),
                                        SizedBox(
                                            height: 30,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder:
                                                            (context) => BuyNow(
                                                                  product: cubit!
                                                                      .homemodel!
                                                                      .data!
                                                                      .products[index],
                                                                )));
                                              },
                                              child: Text(
                                                'Buy',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.orange[800])),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ]));
                        },
                      );
                    },
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator())),
              ),
            ],
          );
        },
      ),
    );
  }
}
