import 'package:flutter/material.dart';
import 'package:bulkers/utils/styles/index.dart';

class MyButtomNavigationBar extends StatefulWidget {
  const MyButtomNavigationBar({super.key});

  @override
  State<MyButtomNavigationBar> createState() => _MyButtomNavigationBarState();
}

class _MyButtomNavigationBarState extends State<MyButtomNavigationBar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      animationDuration: const Duration(milliseconds: 1000),
      destinations: <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.home, color: ThemeColors.primaryThemeColor),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.work, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.work, color: ThemeColors.primaryThemeColor),
          label: 'My Jobs',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.chat, color: ThemeColors.primaryThemeColor),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.person, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.person, color: ThemeColors.primaryThemeColor),
          label: 'Profile',
        ),
      ],
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      selectedIndex: currentPageIndex,
      backgroundColor: Colors.white,
      elevation: 10,
      // surfaceTintColor: Colors.blue,
      indicatorColor: Colors.white,
    );
  }
}
