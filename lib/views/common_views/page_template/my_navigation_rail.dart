import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

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
    UserProvider up = Provider.of<UserProvider>(context);
    _selectedIndex = up.currentPageIndex;
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: changeDestination,
      minWidth: 80,
      labelType: NavigationRailLabelType.all,
      selectedIconTheme:
          const IconThemeData(color: ThemeColors.primaryThemeColor),
      selectedLabelTextStyle:
          const TextStyle(color: ThemeColors.primaryThemeColor),
      unselectedLabelTextStyle:
          const TextStyle(color: ThemeColors.grey1ThemeColor),
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
      destinations: <NavigationRailDestination>[
        const NavigationRailDestination(
          icon: Icon(Icons.home, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.home, color: ThemeColors.primaryThemeColor),
          label: Text('Home'),
          // padding: EdgeInsets.all(16.0),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.work, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              const Icon(Icons.work, color: ThemeColors.primaryThemeColor),
          label: up.userRole == 'company'
              ? const Text('My Job Posts')
              : const Text('My Jobs'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.chat, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.chat, color: ThemeColors.primaryThemeColor),
          label: Text('Chat'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.person, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              Icon(Icons.person, color: ThemeColors.primaryThemeColor),
          label: Text('Profile'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.login, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.login, color: ThemeColors.primaryThemeColor),
          label: Text('Login'),
        ),
      ],
    );
  }
}
