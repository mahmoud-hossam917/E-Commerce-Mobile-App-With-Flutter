import 'dart:io';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommmerce/componts/applocal.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';

import 'package:ecommmerce/database/modelproduct.dart';
import 'package:ecommmerce/database/storageimages.dart';

import 'package:ecommmerce/pages/buynow.dart';
import 'package:ecommmerce/pages/cart.dart';
import 'package:ecommmerce/pages/edituser.dart';
import 'package:ecommmerce/pages/login.dart';
import 'package:ecommmerce/pages/products.dart';
import 'package:ecommmerce/pages/resultsearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<CurvedNavigationBarState> _navbar =
      GlobalKey<CurvedNavigationBarState>();
  PageController _pagecontroller = PageController();
  TextEditingController _controller = TextEditingController();
  int _page = 0;
  String _text = '';
  bool search = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopState(),
      child: BlocConsumer<ShopState, Status>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              drawer: Drawer(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                        currentAccountPicture: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: (cubit?.loginmodel?.data?.image == '' ||
                                        cubit?.loginmodel?.data?.image == PATH)
                                    ? Image.asset(
                                        'images/person.png',
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        File(cubit!.loginmodel!.data!.image!),
                                        fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () async {
                                    print(cubit!.loginmodel!.data!.image);
                                    Uploadimage img = new Uploadimage();

                                    XFile imagepicked = await img.getimage();
                                    if (imagepicked != null) {
                                      setState(() {
                                        cubit!.loginmodel!.data!.image =
                                            imagepicked.path;
                                      });
                                      await cubit!.UpdateProfile();
                                    }
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: Colors.orange[800],
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        accountName: Text(
                          '${cubit?.loginmodel?.data?.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        accountEmail: Text('${cubit?.loginmodel?.data?.email}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Setting'),
                      onTap: () {
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(20, 250, 200, 800),
                            items: [
                              PopupMenuItem(
                                child: Text('Remove Photo'),
                                onTap: () async {
                                  print(cubit!.loginmodel!.data!.image);
                                  if (cubit!.loginmodel!.data!.image != '') {
                                    setState(() {
                                      cubit!.loginmodel!.data!.image = '';
                                    });
                                    await cubit!.UpdateProfile();
                                  }
                                },
                              )
                            ]);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.help),
                      title: Text('Help'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About us'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.QUESTION,
                            desc: 'Are You want to logout ?',
                            btnOkOnPress: () async {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            btnCancelOnPress: () {})
                          ..show();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Image.asset(
                        'images/buy.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                title: (ShopState.get(context).page < 2)
                    ? SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _controller,
                          onChanged: (val) {
                            setState(() {
                              _text = val;
                            });
                          },
                          maxLength: 500,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 10),
                              filled: true,
                              fillColor: Color(0xFFFFE6AC),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: 'search product',
                              prefixIcon: (_text != null && _text.length > 0)
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _text = '';
                                          _controller.text = '';
                                          search = false;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                        size: 18,
                                      ))
                                  : null,
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    if (_text.length > 0) {
                                      setState(() {
                                        search = true;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ))),
                        ),
                      )
                    : Container(),
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: PageView.builder(
                      controller: _pagecontroller,
                      onPageChanged: (val) {
                        ShopState.get(context).ChangeNevBar(val);
                      },
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return (search)
                            ? ResultSearch(
                                text: _text,
                              )
                            : ShopState.get(context)
                                .ChangeListpage(ShopState.get(context).page);
                      })),
              bottomNavigationBar: CurvedNavigationBar(
                color: Colors.white,
                backgroundColor: Colors.orange.shade800,
                key: ShopState.get(context).navbar,
                items: <Widget>[
                  Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.orange,
                  ),
                  Icon(Icons.favorite, size: 30, color: Colors.orange),
                  Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.orange,
                  ),
                ],
                onTap: (index) {
                  ShopState.get(context).Changepage(index);
                },
              ),
              floatingActionButton: (ShopState.get(context).page < 2)
                  ? SizedBox(
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Cart()));
                        },
                        elevation: 10,
                        splashColor: Colors.orange,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.deepOrange,
                        ),
                      ),
                    )
                  : null,
            );
          }),
    );
  }
}
