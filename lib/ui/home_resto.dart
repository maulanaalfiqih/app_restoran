import 'dart:io';
import 'package:app_restoran/common/styles.dart';
import 'package:app_restoran/data/api/api_resto.dart';
import 'package:app_restoran/provider/provider_resto.dart';
import 'package:app_restoran/ui/detail_resto.dart';
import 'package:app_restoran/utils/notification_helper.dart';
import 'package:app_restoran/widget/multi_platform.dart';
import 'package:app_restoran/ui/list_resto.dart';
import 'package:app_restoran/ui/search_resto_page.dart';
import 'package:app_restoran/ui/setting_resto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../provider/provider_scheduling_resto.dart';

class HomeResto extends StatefulWidget {
  static const routeName = '/home_resto';

  const HomeResto({Key? key}) : super(key: key);

  @override
  State<HomeResto> createState() => _HomeRestoState();
}

class _HomeRestoState extends State<HomeResto> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Resto Onlen';

  final List<Widget> _listWidget = [
    const ListResto(),
    const SettingsResto(),
    const SearchRestoPage(),
    //const FavoriteRestoPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
          Platform.isIOS ? CupertinoIcons.square_grid_2x2 : Icons.food_bank),
      label: _headlineText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: SettingsResto.settingsTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.info : Icons.search),
      label: SearchRestoPage.searchTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _androidStyle(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _iosStyle(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailResto.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiPlatform(
      androidStyle: _androidStyle,
      iosStyle: _iosStyle,
    );
  }
}
