import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackGroundFileUpload extends StatefulWidget {
  const BackGroundFileUpload({Key? key}) : super(key: key);

  @override
  _BackGroundFileUploadState createState() => _BackGroundFileUploadState();
}

class _BackGroundFileUploadState extends State<BackGroundFileUpload>
    with SingleTickerProviderStateMixin {
  bool isHover = false;
  var currentPosition = const Offset(0, 0);
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: areaChild(context),
    );
  }

  Center areaChild(BuildContext context) {
    return Center(
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHover = true;
            currentPosition = event.position;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
            currentPosition = const Offset(0, 0);
          });
        },
        child: Transform.translate(
          offset: isHover ? const Offset(0, 0) : const Offset(0, 0),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: isHover
                  ? const LinearGradient(colors: [
                      Color(0xFF00ff59),
                      Color(0xFF02b3ff),
                    ])
                  : const LinearGradient(colors: [
                      Color(0xFF2a5a3b),
                      Color(0xFF1e4886),
                    ]),
            ),
            child: Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'XFIAN DEV',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      'Flutter web design',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
