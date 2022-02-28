import 'package:flutter/material.dart';

class Mybotton extends StatelessWidget {
  const Mybotton({Key? key, this.page}) : super(key: key);
  final page;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => page));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.orange[650]),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      child: Text(
        'Continue',
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }
}
