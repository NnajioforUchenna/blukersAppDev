import 'package:blukers/providers/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/homeIcon.svg',
          ),
          selectedIcon: SvgPicture.asset('assets/icons/homeIcon.svg',
              color: ThemeColors.primaryThemeColor),
          label: AppLocalizations.of(context)!.home,
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/jobsIcon.svg',
          ),
          selectedIcon: SvgPicture.asset('assets/icons/jobsIcon.svg',
              color: ThemeColors.primaryThemeColor),
          label: "Saved",
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/chatIcon.svg',
          ),
          selectedIcon: SvgPicture.asset('assets/icons/chatIcon.svg',
              color: ThemeColors.primaryThemeColor),
          label: AppLocalizations.of(context)!.chat,
        ),
        NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/servicesIcon.svg',
            ),
            selectedIcon: SvgPicture.asset('assets/icons/servicesIcon.svg',
                color: ThemeColors.primaryThemeColor),
            label: "Services"),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/profileIcon.svg',
          ),
          selectedIcon: SvgPicture.asset('assets/icons/profileIcon.svg',
              color: ThemeColors.primaryThemeColor),
          label: up.appUser == null
              ? AppLocalizations.of(context)!.loginRegister
              : AppLocalizations.of(context)!.profile,
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
      indicatorColor: Colors.white,
    );
  }
}
