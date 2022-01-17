import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({Key? key}) : super(key: key);

  @override
  _SideBarMenuState createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  final key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: Drawer(
        child: ListView(
          children: [
            Text('sjhgfjd'),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("hdjgfjdhgjf sliver"),
            automaticallyImplyLeading: MediaQuery.of(context).size.width < 700,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    key.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
