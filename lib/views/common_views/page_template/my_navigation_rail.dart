import 'package:flutter/material.dart';
import '../../../utils/styles/index.dart';

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
      minWidth: 80,
      labelType: NavigationRailLabelType.all,
      selectedIconTheme: const IconThemeData(color: ThemeColors.primaryThemeColor),
      selectedLabelTextStyle: TextStyle(color: ThemeColors.primaryThemeColor),
      unselectedLabelTextStyle: const TextStyle(color: ThemeColors.grey1ThemeColor),
      elevation: 5,
      useIndicator: false,
      backgroundColor: Colors.white,
      indicatorColor: Colors.white,
      leading: Column(
        children: [
          Image.asset(
            'assets/images/looking_for_you.png',
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
          icon: Icon(Icons.home, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.home, color: ThemeColors.primaryThemeColor),
          label: Text('Home'),
          // padding: EdgeInsets.all(16.0),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.work, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.work, color: ThemeColors.primaryThemeColor),
          label: Text('My Jobs'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.chat, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.chat, color: ThemeColors.primaryThemeColor),
          label: Text('Chat'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.person, color: ThemeColors.primaryThemeColor),
          label: Text('Profile'),
        ),
      ],
    );
  }
}
