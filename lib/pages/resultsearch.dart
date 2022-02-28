import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';
import 'package:ecommmerce/database/modelproduct.dart';
import 'package:ecommmerce/pages/buynow.dart';
import 'package:ecommmerce/pages/editproduct.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultSearch extends StatefulWidget {
  ResultSearch({Key? key, required this.text}) : super(key: key);

  String text;
  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  bool favorite = false;
  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopState()
        ..Search(text: widget.text, token: cubit!.loginmodel!.data!.token!),
      child: BlocConsumer<ShopState, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopState app = ShopState.get(context);
          cubit!.results = ShopState.get(context).results;
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: (state is LoadingSearch)
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 10,
                                width: MediaQuery.of(context).size.width,
                                child: LinearProgressIndicator()),
                          ],
                        ),
                      ],
                    )
                  : (cubit!.results!.status == true)
                      ? GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: .65),
                          itemCount: cubit?.results!.data!.products.length,
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
                                            '${cubit!.results!.data!.products[index].image}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          child: IconButton(
                                              onPressed: () async {
                                                app.ChangeFavorite(index, true);

                                                await app.AddToFavorite(
                                                    productID: cubit!
                                                        .results!
                                                        .data!
                                                        .products[index]
                                                        .id);
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: (cubit!
                                                            .results!
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
                                                      '${cubit!.results!.data!.products[index].name}',
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
                                                    '\$ ${cubit!.results!.data!.products[index].price}',
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
                                                              (context) =>
                                                                  BuyNow(
                                                                    product: cubit!
                                                                        .results!
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
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .orange[800])),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]));
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 80, top: 20),
                          child: Text(
                            'No Results Found',
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          )));
        },
      ),
    );
  }
}
