import 'package:flutter/material.dart';

import 'main_learning.dart';

class CustomPaintPage extends StatefulWidget {
  const CustomPaintPage({Key? key}) : super(key: key);

  @override
  _CustomPaintPageState createState() => _CustomPaintPageState();
}

class _CustomPaintPageState extends State<CustomPaintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Paint")),
      body: Container(
        color: Colors.yellow[100],
        child: CustomPaint(
          painter: MyCustomPainter(),
        ),
      ),
    );
  }
}
