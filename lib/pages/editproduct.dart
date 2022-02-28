import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommmerce/database/modelproduct.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Editproduct extends StatefulWidget {
  Editproduct({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  State<Editproduct> createState() => _EditproductState();
}

class _EditproductState extends State<Editproduct> {
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.orange[500],
        leadingWidth: 400,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            height: MediaQuery.of(context).size.height * .19,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'images/buy.png',
                  width: 80,
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Positioned(
                      bottom: 0,
                      child: Text(
                        'Area.com',
                        style: GoogleFonts.pacifico(
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: hi,
        width: wi,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
              key: _key,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('Edit Product',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            fontSize: 20)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: TextFormField(
                      cursorColor: Colors.orange[500],
                      validator: (val) {
                        if (val != null && val.length == 0 || val == null)
                          return 'Enter Name of product';
                      },
                      onSaved: (NewVal) {
                        setState(() {
                          widget.product.Name = NewVal;
                        });
                      },
                      initialValue: '${widget.product.Name}',
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFE6AC),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Name of product',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: TextFormField(
                      validator: (val) {
                        if (val != null && val.length == 0 || val == null)
                          return 'Enter SubName of product';
                      },
                      onSaved: (NewVal) {
                        setState(() {
                          widget.product.subname = NewVal;
                        });
                      },
                      initialValue: '${widget.product.subname}',
                      cursorColor: Colors.orange[500],
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFE6AC),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Sub title',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: TextFormField(
                      validator: (val) {
                        if (val != null && val.length == 0 || val == null)
                          return 'Enter Descripton of product';
                      },
                      onSaved: (NewVal) {
                        setState(() {
                          widget.product.desc = NewVal;
                        });
                      },
                      initialValue: '${widget.product.desc}',
                      cursorColor: Colors.orange[500],
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFE6AC),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'About product',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: TextFormField(
                      validator: (val) {
                        if (val != null && val.length == 0 || val == null)
                          return 'Enter Price of product';
                        else {
                          int zeros = 0;
                          bool flag = false;
                          for (int i = val.length - 1; i >= 0; i--) {
                            if (val[i] == '.') {
                              flag = true;
                              break;
                            }
                            zeros += 1;
                          }
                          if (flag && zeros != 2 || !flag) {
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                desc:
                                    'Price should have to contain two digit after . like 30.00',
                                btnOkOnPress: () {})
                              ..show();
                            return '';
                          }
                        }
                      },
                      onSaved: (NewVal) {
                        setState(() {
                          widget.product.price = NewVal;
                        });
                      },
                      initialValue: '${widget.product.price}',
                      cursorColor: Colors.orange[500],
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFE6AC),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Price',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 100,
                    height: 70,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Image.network(
                      '${widget.product.image}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Choose image',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)))),
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          FormState? formdata = _key.currentState;
                          if (formdata != null && formdata.validate()) {
                            formdata.save();
                            widget.product.EditProduct(widget.product);

                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                desc: 'Product Edited Successfuly',
                                btnOkOnPress: () {
                                  Navigator.of(context).pop();
                                })
                              ..show();
                          }
                        },
                        child: Text(
                          'Save changes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orange[800],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)))),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
