import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CanvusLineChart extends StatefulWidget {
  const CanvusLineChart({Key? key}) : super(key: key);

  @override
  _CanvusLineChartState createState() => _CanvusLineChartState();
}

class _CanvusLineChartState extends State<CanvusLineChart> {
  late List<double> weekData;
  double minD = double.maxFinite;
  double maxD = -double.maxFinite;
  double rangeD = 1.0;
  double percentage = 0.0;
  late Timer timer;

  var rng = Random();

  @override
  void initState() {
    super.initState();

    // setup animation timer and update variable
    _init();
  }

  _init() {
    weekData = [];
    for (var i = 0; i < 7; i++) {
      weekData.add(rng.nextDouble() * 100.0);
    }
    weekData.forEach((d) {
      minD = d < minD ? d : minD;
      maxD = d > maxD ? d : maxD;
    });
    rangeD = maxD - minD;

    final fps = 50.0;
    final totalAnimDuration = 3.0; // animate for x seconds
    var percentStep = 1.0 / (totalAnimDuration * fps);
    var frameDuration = (1000 ~/ fps);
    timer = Timer.periodic(Duration(milliseconds: frameDuration), (timer) {
      setState(() {
        percentage += percentStep;
        percentage = percentage > 1.0 ? 1.0 : percentage;
        if (percentage >= 1.0) timer.cancel();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canvus line chart')),
      body: CustomPaint(
        child: Container(),
        painter: MyLineChartPaint(weekData, minD, maxD, rangeD, percentage),
      ),
    );
  }
}

class MyLineChartPaint extends CustomPainter {
  final List<double> weekData;
  final double minD;
  final double maxD;
  final double rangeD;
  final double percentage;
  MyLineChartPaint(
      this.weekData, this.minD, this.maxD, this.rangeD, this.percentage);

  final double width = 300.0,
      height = 400.0,
      chartWidth = 250,
      chartHeight = 150;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawPaint(paint);
    drawFram(canvas, center);
    drawChart(canvas, center);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawFram(Canvas canvas, Offset center) {
    var rect = Rect.fromCenter(center: center, width: width, height: height);
    var bg = Paint()..color = Colors.grey.shade200;
    canvas.drawRect(rect, bg);
    var border = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawRect(rect, border);
  }

  void drawChart(Canvas canvas, Offset center) {
    var rect =
        Rect.fromCenter(center: center, width: chartWidth, height: chartHeight);

    var border = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    var dpPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    var titleStyle = TextStyle(
      color: Colors.black,
      fontSize: 40,
      fontWeight: FontWeight.w900,
    );
    var labelStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );

    drawChartBorder(canvas, border, rect);

    drawDataPoints(canvas, dpPaint, rect);

    drawHoraizontalLine(canvas, border, rect);
    drawChartLine(canvas, border, rect);

    // draw chart title
    drawText(canvas, rect.topLeft + Offset(0, -60), rect.width, titleStyle,
        "Weekly Data");
    drawLabels(canvas, rect, labelStyle);
  }

  drawText(Canvas canvas, Offset position, double width, TextStyle style,
      String text) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: width);
    textPainter.paint(canvas, position);
  }

  void drawLabels(Canvas canvas, Rect rect, TextStyle labelStyle) {
    final xLabel = ["M", "T", "W", "T", "F", "S", "S"];
    var colW = chartWidth / 6.0;
    // draw x Label
    var x = rect.left;
    for (var i = 0; i < 7; i++) {
      drawText(canvas, Offset(x, rect.bottom + 15), 20, labelStyle, xLabel[i]);
      x += colW;
    }

    //draw y Label
    drawText(canvas, rect.bottomLeft + Offset(-35, -10), 40, labelStyle,
        minD.toStringAsFixed(1)); // print min value
    drawText(canvas, rect.topLeft + Offset(-35, 0), 40, labelStyle,
        maxD.toStringAsFixed(1)); // print max value
  }

  void drawChartBorder(Canvas canvas, Paint paint, Rect rect) {
    canvas.drawRect(rect, paint);
  }

  void drawHoraizontalLine(Canvas canvas, Paint border, Rect rect) {
    var colW = chartWidth / 6;
    var x = rect.left;
    for (int i = 0; i < 6; i++) {
      var p1 = Offset(x, rect.top);
      var p2 = Offset(x, rect.bottom);
      canvas.drawLine(p1, p2, border);
      x += colW;
    }
  }

  void drawDataPoints(Canvas canvas, dpPaint, Rect rect) {
    if (weekData.isEmpty) return;
    // this ratio is the number of y pixels per unit data
    var yRatio = chartHeight / rangeD;
    var colW = chartWidth / 6.0;
    var p = Path();
    var x = rect.left;
    bool first = true;
    weekData.forEach((d) {
      // (d-minD) because we start our range at min value
      var y = (d - minD) * yRatio * percentage;
      if (first) {
        p.moveTo(x, rect.bottom - y);
        first = false;
      } else {
        p.lineTo(x, rect.bottom - y);
      }
      x += colW;
    });

    p.moveTo(x - colW, rect.bottom);
    p.moveTo(rect.left, rect.bottom);
    canvas.drawPath(p, dpPaint);
  }

  void drawChartLine(Canvas canvas, Paint border, Rect rect) {}
}
