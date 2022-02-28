import 'package:ecommmerce/database/delivarymodel.dart';
import 'package:ecommmerce/pages/order.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  Payment({Key? key, required this.delivary}) : super(key: key);
  final DelivaryModel delivary;
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int way = -1;
  int way2 = -1;
  dynamic payment = ['images/Gpay2.png', 'images/apple.png', 'images/visa.png'];
  dynamic shipping = ['images/feedx.jpg', 'images/dhl2.png'];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .12,
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 12,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 90),
                  child: Text(
                    'Payment',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        decoration: TextDecoration.none),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Payment Methods',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        way = 0;
                      });
                    },
                    child: Image.asset(
                      'images/Gpay2.png',
                      height: 50,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: (way == 0) ? Colors.orange : Colors.white,
                            width: 2))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        way = 1;
                      });
                    },
                    child: Image.asset(
                      'images/apple.png',
                      height: 30,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(
                            color: (way == 1) ? Colors.orange : Colors.white,
                            width: 2)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        way = 2;
                      });
                    },
                    child: Image.asset(
                      'images/visa.png',
                      height: 50,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: (way == 2) ? Colors.orange : Colors.white,
                            width: 2))),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Shipping Services',
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        way2 = 0;
                      });
                    },
                    child: Image.asset(
                      'images/feedx.jpg',
                      height: 50,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: (way2 == 0) ? Colors.orange : Colors.white,
                            width: 2))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        way2 = 1;
                      });
                    },
                    child: Image.asset(
                      'images/dhl2.png',
                      height: 50,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: (way2 == 1) ? Colors.orange : Colors.white,
                            width: 2))),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (way != -1 && way2 != -1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Order(
                              delivary: widget.delivary,
                              payment: payment[way],
                              shipping: shipping[way2],
                            )));
                  }
                },
                child: Text(
                  'Order Now',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStateProperty.all(
                        (way != -1 && way2 != -1)
                            ? Colors.orange[700]
                            : Colors.grey[400])),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
