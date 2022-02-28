import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';
import 'package:ecommmerce/pages/buynow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorite extends StatefulWidget {
  Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopState()..GetAllFavorites(token: cubit!.loginmodel!.data!.token!),
      child: BlocConsumer<ShopState, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit!.allFavorites = ShopState.get(context).allFavorites;
          return Container(
            height: MediaQuery.of(context).size.height - 250,
            width: MediaQuery.of(context).size.width,
            child: ConditionalBuilder(
                condition: state is! LoadingFavorite,
                builder: (context) {
                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: .65),
                    itemCount: cubit!.allFavorites!.data!.items.length,
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
                                      '${cubit!.allFavorites!.data!.items[index].image}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () async {},
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${cubit!.allFavorites!.data!.items[index].name}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              '\$ ${cubit!.allFavorites!.data!.items[index].price}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ],
                                        )),
                                    Spacer(),
                                    SizedBox(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BuyNow(
                                                          product: cubit!
                                                              .allFavorites!
                                                              .data!
                                                              .items[index],
                                                        )));
                                          },
                                          child: Text(
                                            'Buy',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
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
          );
        },
      ),
    );
  }
}
