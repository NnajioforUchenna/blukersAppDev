import 'package:flutter/material.dart';

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
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.groups),
          label: 'Workers',
        ),
        NavigationDestination(
          icon: Icon(Icons.work_history),
          label: 'Explore',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      selectedIndex: currentPageIndex,
      backgroundColor: Colors.blue,
      elevation: 10,
      surfaceTintColor: Colors.limeAccent,
    );
  }
}
