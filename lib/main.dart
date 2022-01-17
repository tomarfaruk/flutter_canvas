import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canvas/popup/popup.dart';
import 'package:flutter_canvas/side_bar_menu.dart';
import 'package:get/get.dart';
import 'backgournd_task/background_file_upload.dart';
import 'border_animtaion/border_animation.dart';
import 'bottomTextField.dart';
import 'custom_background_scroll_page/custom_background_page.dart';
import 'custom_canvus_line_chart/canvus_line_chart.dart';
import 'custom_path_clip/custom_path_clip.dart';
import 'furniture_app/furniture_app.dart';
import 'image_canvas/image_canvas.dart';
import 'miniplayer/mini_player_page.dart';
import 'on_hover.dart';
import 'paint_canves/custom_paint_page.dart';
import 'social_auth/facebook_auth_page.dart';
import 'social_auth/google_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Canvas Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Canvas')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Text('image canvas'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ImageCanvasScreen()));
            },
          ),
          ElevatedButton(
            child: Text('CustomBackgroundPage'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CustomBackgroundPage()));
            },
          ),
          ElevatedButton(
            child: Text('FurnitureAppPage'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => FurnitureAppPage()));
            },
          ),
          ElevatedButton(
            child: Text('CustomPaintPage'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CustomPaintPage()));
            },
          ),
          ElevatedButton(
            child: Text('CustomPathClipPage'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CustomPathClipPage()));
            },
          ),
          ElevatedButton(
            child: Text('CanvusLineChart'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CanvusLineChart()));
            },
          ),
          ElevatedButton(
            child: Text('MiniPlayer'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MiniPlayer()));
            },
          ),
          ElevatedButton(
            child: Text('BottomTextField'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BottomTextField()));
            },
          ),
          ElevatedButton(
            child: Text('BackGroundFileUpload'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BackGroundFileUpload()));
            },
          ),
          ElevatedButton(
            child: Text('BorderAnimationPage'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BorderAnimationPage()));
            },
          ),
          ElevatedButton(
            child: Text('GoogleAuthPage'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => GoogleAuthPage()));
            },
          ),
          ElevatedButton(
            child: Text('FacebookAuthPage'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => FacebookAuthPage()));
            },
          ),
          ElevatedButton(
            child: Text('OnHover popup'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => OnHoverPage()));
            },
          ),
          ElevatedButton(
            child: Text('PopoverExample popup'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PopoverExample()));
            },
          ),
        ],
      ),
    );
  }
}
