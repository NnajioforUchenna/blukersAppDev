import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../providers/user_provider.dart';

class MyNavigationRail extends StatefulWidget {
  const MyNavigationRail({super.key});

  @override
  State<MyNavigationRail> createState() => _MyNavigationRailState();
}

class _MyNavigationRailState extends State<MyNavigationRail> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    _selectedIndex = up.currentPageIndex;
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        up.navigate(context, index);
      },
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
          icon: Icon(UniconsLine.estate, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              Icon(UniconsLine.estate, color: ThemeColors.primaryThemeColor),
          label: Text('Home'),
          // padding: EdgeInsets.all(16.0),
        ),
        NavigationRailDestination(
          icon: const Icon(UniconsLine.briefcase_alt,
              color: ThemeColors.grey1ThemeColor),
          selectedIcon: const Icon(UniconsLine.briefcase_alt,
              color: ThemeColors.primaryThemeColor),
          label: up.userRole == 'company'
              ? const Text('Jobs')
              : const Text('Jobs'),
        ),
        const NavigationRailDestination(
          icon: Icon(UniconsLine.chat, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              Icon(UniconsLine.chat, color: ThemeColors.primaryThemeColor),
          label: Text('Chat'),
        ),
        const NavigationRailDestination(
          icon: Icon(UniconsLine.user, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              Icon(UniconsLine.user, color: ThemeColors.primaryThemeColor),
          label: Text('Profile'),
        ),
      ],
    );
  }
}
