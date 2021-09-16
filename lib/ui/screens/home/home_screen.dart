import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qasimati/ui/screens/Store/allStores.dart';
import 'package:qasimati/ui/screens/home/components/header.dart';
import 'package:qasimati/ui/screens/home/homeBody.dart';
import 'package:qasimati/ui/screens/proflie/profileScreen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final List<Widget> children = [
    AllStores(),
    HomeBody(),
    ProfileScreen(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: _currentIndex == 1 ? Header() : null,
      extendBody: true,
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store,
              size: 30,
            ),
            label: 'Stores'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            label: 'Menu'.tr,
          ),
        ],
      ),
    );
  }
}
