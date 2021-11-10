// 1
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCustomPainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.brown;
    Paint sunPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.deepOrange;

    Path path = Path();
    path.moveTo(100, 100);
    path.addOval(Rect.fromCircle(center: Offset(100, 100), radius: 25));
    // path.addOval(Rect.fromCircle(center: Offset(100, 100), radius: 50));
    canvas.drawPath(path, sunPaint);

    path = Path();
    path.moveTo(10, Get.height / 2);
    path.lineTo(100, Get.height / 2.4);
    path.lineTo(120, Get.height / 2.6);
    path.lineTo(140, Get.height / 3);
    path.lineTo(160, Get.height / 2.6);
    path.lineTo(180, Get.height / 2.4);
    path.lineTo(270, Get.height / 2);
    path.lineTo(100, Get.height / 1.9);
    path.lineTo(10, Get.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter delegate) {
    return true;
  }
}
