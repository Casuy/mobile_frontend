import 'package:flutter/material.dart';
import 'package:flutter_events/pages/default_page.dart';
import 'package:flutter_events/pages/discover_page.dart';
import 'package:flutter_events/pages/events_page.dart';
import 'package:flutter_events/pages/home_page.dart';
import 'package:flutter_events/pages/my_page.dart';
import 'package:flutter_events/pages/search_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.black;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[HomePage(), DiscoverPage(), EventsPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _defaultColor),
                activeIcon: Icon(Icons.home, color: _activeColor),
                title: Text('Home',
                    style: TextStyle(
                        fontSize: 16,
                        color: _currentIndex != 0
                            ? _defaultColor
                            : _activeColor))),
            BottomNavigationBarItem(
                icon: Icon(Icons.public, color: _defaultColor),
                activeIcon: Icon(Icons.public, color: _activeColor),
                title: Text('Discover',
                    style: TextStyle(
                        fontSize: 16,
                        color: _currentIndex != 1
                            ? _defaultColor
                            : _activeColor))),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps, color: _defaultColor),
                activeIcon: Icon(Icons.apps, color: _activeColor),
                title: Text('Events',
                    style: TextStyle(
                        fontSize: 16,
                        color: _currentIndex != 2
                            ? _defaultColor
                            : _activeColor))),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: _defaultColor),
                activeIcon: Icon(Icons.person, color: _activeColor),
                title: Text('My',
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            _currentIndex != 3 ? _defaultColor : _activeColor)))
          ]),
    );
  }
}
