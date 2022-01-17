import 'package:flutter/material.dart';

class OnHoverPage extends StatefulWidget {
  const OnHoverPage({Key? key}) : super(key: key);

  @override
  _OnHoverPageState createState() => _OnHoverPageState();
}

class _OnHoverPageState extends State<OnHoverPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey _menuKey = new GlobalKey();
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
        key: _key,
        itemBuilder: (_) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  child: const Text('Doge'), value: 'Doge'),
              new PopupMenuItem<String>(
                  child: const Text('Lion'), value: 'Lion'),
            ],
        onSelected: (_) {});

    final tile = new ListTile(
        title: new Text('Doge or lion?'),
        trailing: button,
        onTap: () {
          // This is a hack because _PopupMenuButtonState is private.
          dynamic state = _menuKey.currentState;
          state.showButtonMenu();
        });
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            key: _key,
            itemBuilder: (context) {
              return <PopupMenuEntry<int>>[
                PopupMenuItem(child: Text('0'), value: 0),
                PopupMenuItem(child: Text('1'), value: 1),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _key.currentState!.showButtonMenu();
            },
            child: Text('Hello'),
          ),
          Center(child: tile),
        ],
      ),
    );
  }
}
