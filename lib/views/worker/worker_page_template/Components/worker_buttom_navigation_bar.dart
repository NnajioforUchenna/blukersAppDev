import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../providers/app_settings_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/index.dart';

class WorkerButtomNavigationBar extends StatefulWidget {
  const WorkerButtomNavigationBar({super.key});

  @override
  State<WorkerButtomNavigationBar> createState() =>
      _WorkerButtomNavigationBarState();
}

class _WorkerButtomNavigationBarState extends State<WorkerButtomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    currentPageIndex = up.currentPageIndex;
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Showcase(
      key: asp.bottomNavigation,
      description: 'This is App Navigation Bar',
      overlayOpacity: 0.6,
      targetShapeBorder: const CircleBorder(),
      tooltipBackgroundColor: const Color.fromRGBO(30, 117, 187, 1),
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      child: NavigationBar(
        animationDuration: const Duration(milliseconds: 300),
        destinations: <Widget>[
          NavigationDestination(
            icon: buildCustomIcon(
              context,
              'assets/icons/jobs-icon.png',
              ThemeColors.grey1ThemeColor,
            ),
            selectedIcon: buildCustomIcon(
              context,
              'assets/icons/jobs-icon-selected.png',
              ThemeColors.primaryThemeColor,
            ),
            label: AppLocalizations.of(context)!.jobs,
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
              'assets/icons/search-icon.png',
              ThemeColors.grey1ThemeColor,
            ),
            selectedIcon: buildCustomIcon(
              context,
              'assets/icons/search-icon-selected.png',
              ThemeColors.primaryThemeColor,
            ),
            label: AppLocalizations.of(context)!.searchJobs,
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
          up.navigateWorker(context, index);
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.white,
        elevation: 10,
        indicatorColor: Colors.white,
      ),
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
