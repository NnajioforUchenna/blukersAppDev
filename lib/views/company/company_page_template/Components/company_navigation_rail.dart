import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/theme_colors.dart';

class CompanyNavigationRail extends StatefulWidget {
  const CompanyNavigationRail({super.key});

  @override
  State<CompanyNavigationRail> createState() => _CompanyNavigationRailState();
}

class _CompanyNavigationRailState extends State<CompanyNavigationRail> {
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
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          icon: SvgPicture.asset('assets/icons/homeIcon.svg',
              color: ThemeColors.grey1ThemeColor),
          selectedIcon: SvgPicture.asset('assets/icons/homeIcon.svg',
              color: ThemeColors.primaryThemeColor),
          label: Text(AppLocalizations.of(context)!.home),
        ),
        NavigationRailDestination(
          icon: SvgPicture.asset('assets/icons/jobsIcon.svg',
              color: ThemeColors.grey1ThemeColor),
          selectedIcon: SvgPicture.asset('assets/icons/jobsIcon.svg',
              color: ThemeColors.primaryThemeColor),
          label: Text(AppLocalizations.of(context)!.jobs),
        ),
        NavigationRailDestination(
          icon: SvgPicture.asset('assets/icons/search.svg',
              color: ThemeColors.grey1ThemeColor),
          selectedIcon: SvgPicture.asset('assets/icons/search.svg',
              color: ThemeColors.primaryThemeColor),
          label: Text(AppLocalizations.of(context)!.searchJobs),
        ),
        NavigationRailDestination(
          icon: SvgPicture.asset('assets/icons/servicesIcon.svg',
              color: ThemeColors.grey1ThemeColor),
          selectedIcon: SvgPicture.asset('assets/icons/servicesIcon.svg',
              color: ThemeColors.primaryThemeColor),
          label: const Text("Services"),
        ),
        NavigationRailDestination(
          icon: SvgPicture.asset('assets/icons/profileIcon.svg',
              color: ThemeColors.grey1ThemeColor),
          selectedIcon: SvgPicture.asset('assets/icons/profileIcon.svg',
              color: ThemeColors.primaryThemeColor),
          label: up.appUser == null
              ? Text(AppLocalizations.of(context)!.loginRegister)
              : Text(AppLocalizations.of(context)!.profile),
        ),
      ],
    );
  }
}
