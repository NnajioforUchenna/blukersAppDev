import 'package:flutter/material.dart';

class MyNavigationRail extends StatefulWidget {
  const MyNavigationRail({super.key});

  @override
  State<MyNavigationRail> createState() => _MyNavigationRailState();
}

class _MyNavigationRailState extends State<MyNavigationRail> {
  int _selectedIndex = 0;

  void changeDestination(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: changeDestination,
      minWidth: 100,
      labelType: NavigationRailLabelType.all,
      selectedIconTheme: const IconThemeData(color: Colors.white),
      selectedLabelTextStyle: TextStyle(color: Colors.lightBlue[500]),
      unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
      elevation: 5,
      useIndicator: true,
      backgroundColor: Colors.blue[200],
      indicatorColor: Colors.pink,
      leading: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            width: 150,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
      // trailing: const MyTrailingWidget(),
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.groups),
          label: Text('Workers'),
          padding: EdgeInsets.all(16.0),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.work_history),
          label: Text('Explore'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.chat),
          label: Text('Chat'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text('Profile'),
        ),
      ],
    );
  }
}
