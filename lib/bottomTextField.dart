import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomTextField extends StatefulWidget {
  const BottomTextField({Key? key}) : super(key: key);

  @override
  _BottomTextFieldState createState() => _BottomTextFieldState();
}

class _BottomTextFieldState extends State<BottomTextField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: GestureDetector(
        onTap: () {
          Get.bottomSheet(
            Container(
              color: Colors.white,
              child: TextFormField(
                decoration: InputDecoration(hintText: "Type something"),
              ),
            ),
          );
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text("click here"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: double.infinity,
              height: 600,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
