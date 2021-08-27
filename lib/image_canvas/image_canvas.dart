import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ImageCanvasScreen extends StatefulWidget {
  const ImageCanvasScreen({Key? key}) : super(key: key);

  @override
  _ImageCanvasScreenState createState() => _ImageCanvasScreenState();
}

class _ImageCanvasScreenState extends State<ImageCanvasScreen> {
  final images = <ui.Image>[];
  ui.Image? selectedImage;
  int selectedIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadImages().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return Scaffold(
      appBar: AppBar(title: Text('Image Canvas')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : GestureDetector(
                onTap: () {
                  setState(() {
                    this.selectedIndex++;
                    this.selectedImage = this.images.length > 0
                        ? this.images[this.selectedIndex % this.images.length]
                        : null;
                    print(
                        "Selected image index = ${this.selectedIndex % this.images.length}");
                  });
                },
                child: CustomPaint(
                  child: Container(),
                  painter: MyCanvas(
                      selected: selectedIndex,
                      bgImg: selectedImage,
                      imageCount: images.length),
                ),
              ),
      ),
    );
  }

  final imageAssets = <String>[
    'one.jpg',
    'two.jpg',
    'three.jpg',
    'four.jpg',
    'five.jpg'
  ];
  Future<void> _loadImages() async {
    images.clear();
    for (var item in imageAssets) {
      final rootImage = await rootBundle.load('assets/images/$item');
      final img = await decodeImageFromList(rootImage.buffer.asUint8List());
      images.add(img);
    }
    selectedImage = images.length > 0 ? images[0] : null;
  }
}

class MyCanvas extends CustomPainter {
  ui.Image? bgImg;
  final int selected, imageCount;
  late Size size;

  MyCanvas({this.bgImg, required this.imageCount, required this.selected});
  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;

    var offset = Offset(size.width / 2, size.height / 2);

    if (bgImg != null) {
      final rect = Rect.fromCenter(
          center: offset, width: size.width, height: size.height);
      // drawImage(canvas, offset);
      paintImage(bgImg!, rect, canvas, Paint(), BoxFit.cover);
      drawRect(canvas, offset);
      drawDots(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void paintImage(
      ui.Image image, Rect outputRect, Canvas canvas, Paint paint, BoxFit fit) {
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final FittedSizes sizes = applyBoxFit(fit, imageSize, outputRect.size);
    final Rect inputSubrect =
        Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final Rect outputSubrect =
        Alignment.center.inscribe(sizes.destination, outputRect);
    canvas.drawImageRect(image, inputSubrect, outputSubrect, paint);
  }

  void drawRect(Canvas canvas, Offset offset) {
    final rect =
        Rect.fromCenter(center: offset, width: size.width, height: size.height);
    final border = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawRect(rect, border);
  }

  void drawImage(Canvas canvas, Offset offset) {
    canvas.drawImage(bgImg!, Offset(0, 0), Paint());
  }

  void drawDots(Canvas canvas, Offset offset) {
    var pOff = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = Colors.grey;
    var pOn = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey;

    var radius = 10.0;
    var k = 2 * radius + 5.0;
    var c = Offset(-k * (imageCount - 1.0) / 2.0, size.height / 2 + 20);
    for (var i = 0; i < imageCount; i++) {
      if (i == this.selected % imageCount) {
        canvas.drawCircle(c + offset, radius, pOn);
      } else {
        canvas.drawCircle(c + offset, radius, pOff);
      }
      c += Offset(k, 0);
    }
  }
}
