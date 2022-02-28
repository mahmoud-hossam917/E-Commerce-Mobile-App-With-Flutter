import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommmerce/cache/cachehelper.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';
import 'package:ecommmerce/pages/home.dart';

import 'package:ecommmerce/pages/signup.dart';
import 'package:ecommmerce/pages/slidpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  var email, password;

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ShopState(),
      child: BlocConsumer<ShopState, Status>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.orange[500],
          body: ModalProgressHUD(
            inAsyncCall: (state is loginLoadinge),
            color: Colors.black,
            child: Container(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .19,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'images/buy.png',
                            width: 200,
                            height: 200,
                          ),
                          Positioned(
                              bottom: 0,
                              child: Text(
                                'Area.com',
                                style: GoogleFonts.pacifico(
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hi * .07,
                  ),
                  Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              validator: (val) {
                                if (val != null) {
                                  if (val.length == 0)
                                    return "please enter your email";
                                } else
                                  return "please enter your email";
                              },
                              onSaved: (val) {
                                email = val;
                              },
                              cursorColor: Colors.orange[500],
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFE6AC),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'Enter Your Email',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.orange[500],
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: hi * .03,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              validator: (val) {
                                if (val != null) {
                                  if (val.length == 0)
                                    return "please enter your password";
                                } else
                                  return "please enter your password";
                              },
                              onSaved: (val) {
                                password = val;
                              },
                              cursorColor: Colors.orange[500],
                              obscureText: true,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFE6AC),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: 'Enter Your Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.orange[500],
                                  )),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: hi * .04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 110),
                    child: ElevatedButton(
                      onPressed: () async {
                        var formdata = _globalKey.currentState;
                        if (formdata != null) {
                          if (formdata.validate()) {
                            formdata.save();

                            cubit = ShopState.get(context);

                            await cubit?.userLogin(
                                email: email, password: password);

                            cubit?.loginmodel?.data?.password = password;
                            CachHelper.setData(key: 'email', value: email);
                            CachHelper.setData(
                                key: 'password', value: password);
                            if (cubit!.loginmodel!.status == true) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            } else {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  desc: cubit!.loginmodel!.message,
                                  btnOkOnPress: () {})
                                ..show();
                            }
                          }
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                    ),
                  ),
                  SizedBox(
                    height: hi * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (Context) => Signup()));
                        },
                        child: Text(
                          "Don\'t have an account ? ",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (Context) => Signup()));
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: hi * .08,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'images/facebook.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'images/google.png',
                              width: 50,
                              height: 50,
                            ),
                          )
                        ],
                      ),
                    ),
                    height: hi * .16,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
