import 'package:ecommmerce/componts/mybotton.dart';

import 'package:ecommmerce/pages/home.dart';
import 'package:ecommmerce/pages/login.dart';
import 'package:flutter/material.dart';

class SildPage extends StatefulWidget {
  SildPage({Key? key}) : super(key: key);

  @override
  _SildPageState createState() => _SildPageState();
}

class _SildPageState extends State<SildPage> {
  List intro = [
    {'img': 'images/e1.png', 'caption': 'Welcome to Your Area'},
    {'img': 'images/e3.jpg', 'caption': 'Welcome to Your Area'},
    {'img': 'images/e2.png', 'caption': 'Welcome to Your Area'}
  ];
  var chagepage = 0;
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 30),
            child: Text(
              "Area.com",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (val) {
                setState(() {
                  chagepage = val;
                });
              },
              itemCount: intro.length,
              itemBuilder: (context, index) {
                return TextAndImage(
                    img: intro[index]['img'],
                    caption: intro[index]['caption'],
                    mdw: mdw,
                    mdh: mdh);
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      intro.length, (index) => chagepageview(index)),
                ),
                Spacer(
                  flex: 3,
                ),
                SizedBox(
                    width: 230,
                    child: Mybotton(
                      page: Login(),
                    )),
                Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ],
      )),
    );
  }

  AnimatedContainer chagepageview(index) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 2),
      duration: Duration(microseconds: 500),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(2.5)),
      width: (chagepage == index) ? 20 : 5,
      height: 5,
    );
  }
}

class TextAndImage extends StatelessWidget {
  final img, caption, mdw, mdh;
  const TextAndImage({Key? key, this.img, this.caption, this.mdw, this.mdh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('${caption}'), Image.asset("${img}", width: mdw)],
    );
  }
}
