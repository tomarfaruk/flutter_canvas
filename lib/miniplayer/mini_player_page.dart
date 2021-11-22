import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

final _navigatorKey = GlobalKey<ScaffoldState>();
double playerMinHeight = 20;
MiniplayerController controller = MiniplayerController();
final ValueNotifier<double> playerExpandProgress =
    ValueNotifier(playerMinHeight);

class MiniPlayer extends StatefulWidget {
  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Navigator(
            key: _navigatorKey,
            onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) => FirstScreen(),
            ),
          ),
          Miniplayer(
            minHeight: 50,
            maxHeight: 370,
            valueNotifier: playerExpandProgress,
            controller: controller,
            builder: (height, percentage) => Center(
              child: Text('$height, $percentage'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        fixedColor: Colors.blue,
        onTap: (v) {
          if (v == 0)
            controller.animateToHeight(state: PanelState.MIN);
          else
            controller.animateToHeight(state: PanelState.MAX);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo: FirstScreen')),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
              ),
              child: const Text('Open SecondScreen'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => ThirdScreen()),
              ),
              child: const Text('Open ThirdScreen with root Navigator'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo: SecondScreen')),
      body: Center(child: Text('SecondScreen')),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo: ThirdScreen')),
      body: Center(child: Text('ThirdScreen')),
    );
  }
}
