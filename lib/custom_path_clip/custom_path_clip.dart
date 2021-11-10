import 'package:flutter/material.dart';

class CustomPathClipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("Path Clip")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(height: 20),
          Container(
            // color: Colors.red,
            child: ClipPath(
              clipper: DolDurmaClipper(holeRadius: 25),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  color: Colors.amber,
                ),
                width: 200,
                height: 300,
                padding: EdgeInsets.all(15),
                child: Center(child: Text('first example')),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  final double holeRadius;

  DolDurmaClipper({required this.holeRadius});
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    path.addOval(Rect.fromCircle(center: Offset(0, 0), radius: holeRadius));
    path.addOval(
        Rect.fromCircle(center: Offset(0, size.height), radius: holeRadius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: holeRadius));
    path.addOval(Rect.fromCircle(
        center: Offset(0, size.height / 2), radius: holeRadius));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
