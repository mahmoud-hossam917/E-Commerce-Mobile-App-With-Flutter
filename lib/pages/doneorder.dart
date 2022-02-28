import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';
import 'package:ecommmerce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Doneorder extends StatefulWidget {
  Doneorder({Key? key}) : super(key: key);

  @override
  State<Doneorder> createState() => _DoneorderState();
}

class _DoneorderState extends State<Doneorder> {
  @override
  Widget build(BuildContext context) {
    var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => ShopState(),
      child: BlocConsumer<ShopState, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            height: hi,
            width: wi,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: hi * .2,
                ),
                Container(
                  height: hi * .4,
                  child: Image.asset(
                    'images/order2.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Center(
                  child: Text(
                    'Order Success',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Public Sans',
                        color: Colors.black,
                        fontSize: 30,
                        decoration: TextDecoration.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 30),
                  child: Center(
                    child: Text(
                      'Your packet will be sent to your address,thanks for order',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                          fontSize: 16,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      for (int index = 0;
                          index < cubit!.myCart!.data!.cartItems.length;
                          index++) {
                        cubit!.AddToCart(
                            productId: cubit!
                                .myCart!.data!.cartItems[index].product!.id,
                            token: cubit!.loginmodel!.data!.token!);
                      }
                      cubit!.myCart!.data!.cartItems.clear();

                      cubit!.myCart!.status = false;

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text(
                      'Back to Home',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange[800]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
