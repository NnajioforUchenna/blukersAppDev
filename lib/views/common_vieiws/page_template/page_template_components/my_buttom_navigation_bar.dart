import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/index.dart';
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
          icon: buildCustomIcon(
            context,
            'assets/icons/navicon-01.png',
            ThemeColors.grey1ThemeColor,
          ),
          selectedIcon: buildCustomIcon(
            context,
            'assets/icons/navicon-01-selected.png',
            ThemeColors.primaryThemeColor,
          ),
          label: AppLocalizations.of(context)!.home,
        ),
        NavigationDestination(
          icon: buildCustomIcon(
            context,
            'assets/icons/navicon-02.png',
            ThemeColors.grey1ThemeColor,
          ),
          selectedIcon: buildCustomIcon(
            context,
            'assets/icons/navicon-02-selected.png',
            ThemeColors.primaryThemeColor,
          ),
          label: AppLocalizations.of(context)!.saved,
        ),
        NavigationDestination(
          icon: buildCustomIcon(
            context,
            'assets/icons/navicon-03.png',
            ThemeColors.grey1ThemeColor,
          ),
          selectedIcon: buildCustomIcon(
            context,
            'assets/icons/navicon-03-selected.png',
            ThemeColors.primaryThemeColor,
          ),
          label: AppLocalizations.of(context)!.chat,
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/servicesIcon.svg',
          ),
          selectedIcon: SvgPicture.asset('assets/icons/servicesIcon.svg',
              color: ThemeColors.primaryThemeColor),
          label: AppLocalizations.of(context)!.services,
        ),
        NavigationDestination(
          icon: buildCustomIcon(
            context,
            'assets/icons/navicon-05.png',
            ThemeColors.grey1ThemeColor,
          ),
          selectedIcon: buildCustomIcon(
            context,
            'assets/icons/navicon-05-selected.png',
            ThemeColors.primaryThemeColor,
          ),
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

  Widget buildCustomIcon(context, src, color) {
    return Image.asset(
      src,
      // width: 35,
      height: MediaQuery.of(context).size.height * 0.035,
      fit: BoxFit.contain,
      color: color,
    );
  }
}
