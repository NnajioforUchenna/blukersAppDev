import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          icon: Icon(Icons.home, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.home, color: ThemeColors.primaryThemeColor),
          label: 'Home',
        ),
        NavigationDestination(
          icon: const Icon(Icons.work, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              const Icon(Icons.work, color: ThemeColors.primaryThemeColor),
          label: up.userRole == 'company' ? 'My Job Posts' : 'My Jobs',
        ),
        const NavigationDestination(
          icon: Icon(Icons.chat, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.chat, color: ThemeColors.primaryThemeColor),
          label: 'Chat',
        ),
        const NavigationDestination(
          icon: Icon(Icons.person, color: ThemeColors.grey1ThemeColor),
          selectedIcon:
              Icon(Icons.person, color: ThemeColors.primaryThemeColor),
          label: 'Profile',
        ),
        const NavigationDestination(
          icon: Icon(Icons.login, color: ThemeColors.grey1ThemeColor),
          selectedIcon: Icon(Icons.login, color: ThemeColors.primaryThemeColor),
          label: 'Login',
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
