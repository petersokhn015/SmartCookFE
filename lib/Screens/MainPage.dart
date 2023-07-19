import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/colors.dart';
import 'Home.dart';
import 'Profile.dart';
import 'Search.dart';

class MainPage extends StatefulWidget {
  const MainPage({key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Home(),
    Search(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            selectedItemColor: ColorSet.primaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CommunityMaterialIcons.home,
                  size: 30,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CommunityMaterialIcons.magnify, size: 30),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(CommunityMaterialIcons.account, size: 30),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}
