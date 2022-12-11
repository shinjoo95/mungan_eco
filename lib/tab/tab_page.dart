import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:youth_ecoapp/setting/setting_page.dart';
import 'package:youth_ecoapp/tab/account/account_page.dart';
import 'package:youth_ecoapp/tab/home/home_page.dart';
import 'package:youth_ecoapp/tab/search/search_page.dart';
import 'package:flutter/cupertino.dart';


class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;
  final model = SettingModel();
  final _pages = [
    HomePage(),
    SearchPage(),
    AccountPage(),
    ProfileScreen(
      providerConfigs: [
        EmailProviderConfiguration(),
      ],
      avatarSize: 100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed ,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.green,
        currentIndex: _currentIndex,

        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        } ,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house),label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.trash), label: 'Write'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Profile'),
        ],
      ),
    );
  }
}
