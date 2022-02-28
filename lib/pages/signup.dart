import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';

import 'package:ecommmerce/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  var email, password, confirmpassword, username, phonenumber;
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
            inAsyncCall: state is registerLoadinge,
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
                                    return 'Please enter Your user name';
                                } else
                                  return 'Please enter Your user name';
                              },
                              onSaved: (val) {
                                setState(() {
                                  username = val;
                                });
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
                                  hintText: 'User Name',
                                  prefixIcon: Icon(
                                    Icons.person,
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
                              onSaved: (val) {
                                email = val;
                              },
                              validator: (val) {
                                if (val != null) {
                                  if (val.length == 0)
                                    return "please enter your email";
                                } else
                                  return "please enter your email";
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
                                  hintText: 'Email',
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
                              obscureText: true,
                              onChanged: (val) {
                                setState(() {
                                  confirmpassword = val;
                                });
                              },
                              onSaved: (val) {
                                password = val;
                              },
                              validator: (val) {
                                if (val != null) {
                                  if (val.length < 6)
                                    return 'Password should has to more be 6 digits';
                                } else
                                  return "please enter your password";
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
                                  hintText: 'Enter Your Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
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
                                if (val != confirmpassword) {
                                  return "please enter the correct password";
                                }
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
                                  hintText: 'Confirm Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
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
                                  if (val.length < 11 || val.length > 11)
                                    return 'Phone Number should has to be 11 digit';
                                } else
                                  return 'Please Enter your phone number';
                              },
                              onSaved: (val) {
                                setState(() {
                                  phonenumber = val;
                                });
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
                                  hintText: 'Phone Number',
                                  prefixIcon: Icon(
                                    Icons.phone,
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

                            await ShopState.get(context).SignUp(
                                name: username,
                                email: email,
                                password: password,
                                phone: phonenumber);

                            AwesomeDialog(
                                context: context,
                                dialogType:
                                    (ShopState.get(context).result?['status'] ==
                                            true)
                                        ? DialogType.SUCCES
                                        : DialogType.ERROR,
                                desc: ShopState.get(context).result?['message'],
                                btnOkOnPress: () {
                                  (ShopState.get(context).result?['status'] ==
                                          true)
                                      ? Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => Login()))
                                      : null;
                                })
                              ..show();
                          }
                        }
                      },
                      child: Text(
                        'Sign Up',
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
                    height: hi * .005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "have an account ? ",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: hi * .07,
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
