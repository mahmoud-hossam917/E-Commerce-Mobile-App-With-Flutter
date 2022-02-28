import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommmerce/componts/constant.dart';
import 'package:ecommmerce/cubit/cubit.dart';
import 'package:ecommmerce/cubit/status.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Edituser extends StatefulWidget {
  Edituser({
    Key? key,
  }) : super(key: key);

  @override
  State<Edituser> createState() => _EdituserState();
}

class _EdituserState extends State<Edituser> {
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  String? lastPassword;
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
            height: hi - 250,
            width: wi,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Edit User',
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
                          initialValue: '${cubit?.loginmodel?.data?.name}',
                          validator: (val) {
                            if (val != null && val.length == 0 || val == null)
                              return 'Enter your user name please!';
                          },
                          onSaved: (NewVal) {
                            cubit?.loginmodel?.data?.name = NewVal;
                          },
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
                              labelText: 'username',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: TextFormField(
                          validator: (val) {
                            if (val != null && val.length == 0 || val == null)
                              return 'required';
                            else if (val != cubit?.loginmodel?.data?.password)
                              return 'Please write the correct password';
                          },
                          onSaved: (val) {
                            lastPassword = val;
                          },
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
                              labelText: 'Current Password',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: TextFormField(
                          validator: (val) {
                            if (val == null || val != null && val.length < 6)
                              return 'Password should be more rhan 5 digits';
                            else if (val == cubit?.loginmodel?.data?.password)
                              return 'Password used before';
                          },
                          onSaved: (val) {
                            cubit?.loginmodel?.data?.password = val;
                          },
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
                              labelText: 'New Password',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: TextFormField(
                          initialValue: '${cubit?.loginmodel?.data?.phone}',
                          validator: (val) {
                            if (val != null && val.length != 11 || val == null)
                              return 'Phone number should have to equal 11 digits';
                          },
                          onSaved: (NewVal) {
                            cubit?.loginmodel?.data?.phone = NewVal;
                          },
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
                              labelText: 'Phone number',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () async {
                              FormState? formdata = _key.currentState;
                              if (formdata != null && formdata.validate()) {
                                formdata.save();
                                print(
                                    '${cubit?.loginmodel?.data?.token}-------\n');

                                await cubit?.UpdateProfile();
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    desc: 'User Edited Successfuly',
                                    btnOkOnPress: () {})
                                  ..show();
                              }
                            },
                            child: Text(
                              'Save changes',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
