import 'package:blukers/providers/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class MyButtomNavigationBar extends StatefulWidget {
  const MyButtomNavigationBar({super.key});

  @override
  State<MyButtomNavigationBar> createState() => _MyButtomNavigationBarState();
}

class _MyButtomNavigationBarState extends State<MyButtomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    currentPageIndex = up.currentPageIndex;
    return NavigationBar(
      animationDuration: const Duration(milliseconds: 1000),
      destinations: <Widget>[
        const NavigationDestination(
          icon: Icon(UniconsLine.estate, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              Icon(UniconsLine.estate, color: ThemeColors.primaryThemeColor),
          label: 'Home',
        ),
        NavigationDestination(
          icon: const Icon(UniconsLine.briefcase_alt,
              color: ThemeColors.grey1ThemeColor),
          selectedIcon: const Icon(UniconsLine.briefcase_alt,
              color: ThemeColors.primaryThemeColor),
          label: up.userRole == 'company' ? 'Jobs' : 'Jobs',
        ),
        const NavigationDestination(
          icon: Icon(UniconsLine.chat, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              Icon(UniconsLine.chat, color: ThemeColors.primaryThemeColor),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(UniconsLine.user, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              Icon(UniconsLine.user, color: ThemeColors.primaryThemeColor),
          label: up.appUser == null ? "Login/Register" : 'Profile',
        ),
      ],
      onDestinationSelected: (int index) {
        setState(() {
          up.navigate(context, index);
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
