import 'package:flutter/material.dart';
import 'commodities.dart';
import 'main.dart';

class NavBar extends StatefulWidget {
  final int pageIndex;
  NavBar({Key key, @required this.pageIndex}) : super(key: key);
  @override
  _NavBarState createState() => new _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentTabIndex;

  @override
  initState() {
    super.initState();
    currentTabIndex = widget.pageIndex;
  }

  //For bottom navigation bar
  List<Widget> tabs = [
    MyApp(),
    MyApp(),
    MyApp(),
    MyApp(),
  ];

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: tabs[currentTabIndex],
    bottomNavigationBar: BottomNavigationBar(
      onTap: onTapped,
      currentIndex: currentTabIndex,
      // this will be set when a new tab is tapped
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.rss_feed),
          backgroundColor: Colors.orange,
          title: new Text('Trinidad & Tobago'),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.purple,
          icon: new Icon(Icons.category),
          title: new Text('Barbados'),
        ),
        BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: Icon(Icons.home),
            title: Text('Guyana')),
        BottomNavigationBarItem(
            backgroundColor: Colors.lightBlueAccent,
            icon: Icon(Icons.mail),
            title: Text('Jamaica')),
      ],
    ),
  );
}