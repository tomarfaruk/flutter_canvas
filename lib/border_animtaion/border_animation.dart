import 'package:flutter/material.dart';

class BorderAnimationPage extends StatefulWidget {
  const BorderAnimationPage({Key? key}) : super(key: key);

  @override
  _BorderAnimationPageState createState() => _BorderAnimationPageState();
}

class _BorderAnimationPageState extends State<BorderAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _resizableController;

  static Color colorVariation(int note) {
    if (note <= 1) {
      return Colors.blue[50]!;
    } else if (note > 1 && note <= 2) {
      return Colors.blue[100]!;
    } else if (note > 2 && note <= 3) {
      return Colors.blue[200]!;
    } else if (note > 3 && note <= 4) {
      return Colors.blue[300]!;
    } else if (note > 4 && note <= 5) {
      return Colors.blue[400]!;
    } else if (note > 5 && note <= 6) {
      return Colors.blue;
    } else if (note > 6 && note <= 7) {
      return Colors.blue[600]!;
    } else if (note > 7 && note <= 8) {
      return Colors.blue[700]!;
    } else if (note > 8 && note <= 9) {
      return Colors.blue[800]!;
    }
    return Colors.blue[900]!;
  }

  AnimatedBuilder getContainer() {
    return new AnimatedBuilder(
        animation: _resizableController,
        builder: (context, child) {
          return Container(
            //color: colorVariation((_resizableController.value *100).round()),
            padding: EdgeInsets.all(24),
            child: Text("SAMPLE"),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(
                  color:
                      colorVariation((_resizableController.value * 10).round()),
                  width: 10),
            ),
          );
        });
  }

  @override
  void initState() {
    _resizableController = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 500,
      ),
    );
    _resizableController.addStatusListener((animationStatus) {
      switch (animationStatus) {
        case AnimationStatus.completed:
          _resizableController.reverse();
          break;
        case AnimationStatus.dismissed:
          _resizableController.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }
    });
    _resizableController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: getContainer()),
    );
  }
}
