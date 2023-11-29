import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wicca_store_3/views/homepage.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    Container(
      color: Colors.red,
      child: Center(
        child: Text(
          'Categories Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.red,
      child: Center(
        child: Text(
          'Profile Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Container(
      color: Colors.red,
      child: Center(
        child: Text(
          'Cart Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 60,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Color(0xFF515C6F),
        elevation: 8,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        activeIndex: _selectedIndex,
        itemCount: 4,
        tabBuilder: (index, isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                index == 0
                    ? LineIcons.home
                    : index == 1
                        ? LineIcons.icons
                        : index == 2
                            ? LineIcons.user
                            : LineIcons.shoppingCart,
                size: 30,
                color: isActive ? Colors.white : Color(0xFF727C8E),
              ),
              Text(
                index == 0
                    ? 'Home'
                    : index == 1
                        ? 'Category'
                        : index == 2
                            ? 'Profile'
                            : 'Cart',
                style: TextStyle(
                  color: isActive ? Colors.white : Color(0xFF727C8E),
                ),
              ),
            ],
          );
        },
      ),
      appBar: AppBar(
        title: Text(
          'Let\'s Have Shopping',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF515C6F),
      ),
      body: Column(
        children: <Widget>[_pages[_selectedIndex]],
      ),
    );
  }
}
