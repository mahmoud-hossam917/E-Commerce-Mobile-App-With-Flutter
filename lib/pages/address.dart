import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';
import 'package:ecommmerce/database/delivarymodel.dart';

import 'package:ecommmerce/pages/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Adress extends StatefulWidget {
  Adress({Key? key}) : super(key: key);

  @override
  State<Adress> createState() => _AdressState();
}

class _AdressState extends State<Adress> {
  DelivaryModel delivary = DelivaryModel();
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopState(),
      child: BlocConsumer<ShopState, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .12,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                            left: 10,
                          ),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          'Address',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 40, right: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.more_horiz),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .04,
                ),
                Material(
                  color: Colors.white,
                  child: Form(
                      key: formstate,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Delivary *',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextFormField(
                              validator: (val) {
                                if (val == null ||
                                    val != null && val.length == 0)
                                  return 'required';
                              },
                              onSaved: (val) {
                                delivary.delivary = val;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'City *',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextFormField(
                              validator: (val) {
                                if (val == null ||
                                    val != null && val.length == 0)
                                  return 'required';
                              },
                              onSaved: (val) {
                                delivary.city = val;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Zip Code *',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextFormField(
                              validator: (val) {
                                if (val == null ||
                                    val != null && val.length == 0)
                                  return 'required';
                              },
                              onSaved: (val) {
                                delivary.zipCode = val;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  value: delivary.checkBox,
                                  onChanged: (val) {
                                    setState(() {
                                      delivary.checkBox = !delivary.checkBox;
                                    });
                                  }),
                              Text('Billing address same as a delivery',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .16,
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: 250,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    FormState formData =
                                        formstate.currentState!;
                                    if (formData != null &&
                                        formData.validate()) {
                                      formData.save();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Payment(
                                                    delivary: delivary,
                                                  )));
                                    }
                                  },
                                  child: Text(
                                    'Payment',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 6,
                                      primary: Colors.orange[800],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ))
                        ],
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
