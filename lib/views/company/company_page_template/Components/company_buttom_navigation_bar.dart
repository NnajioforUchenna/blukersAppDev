import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../providers/app_settings_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/theme_colors.dart';

class CompanyButtomNavigationBar extends StatefulWidget {
  const CompanyButtomNavigationBar({super.key});

  @override
  State<CompanyButtomNavigationBar> createState() =>
      _CompanyButtomNavigationBarState();
}

class _CompanyButtomNavigationBarState
    extends State<CompanyButtomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    currentPageIndex = up.currentPageIndex;
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return Showcase(
      key: asp.bottomNavigationCompany,
      description: 'This is App Navigation Bar',
      overlayOpacity: 0.6,
      targetShapeBorder: const CircleBorder(),
      tooltipBackgroundColor: const Color.fromRGBO(30, 117, 187, 1),
      descTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      child: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          up.navigateCompany(context, index);
        },
        unselectedLabelStyle: GoogleFonts.montserrat(
          color: const Color.fromRGBO(140, 140, 140, 1),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        selectedLabelStyle: GoogleFonts.montserrat(
          color: ThemeColors.secondaryThemeColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        selectedItemColor: ThemeColors.secondaryThemeColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: buildCustomIcon(
              context,
              'assets/icons/worker_home_icon.svg',
            ),
            activeIcon: buildCustomIcon(
              context,
              'assets/icons/worker_home_selected.svg',
            ),
            label: AppLocalizations.of(context)!.workers,
          ),
          BottomNavigationBarItem(
            icon: buildCustomIcon(
              context,
              'assets/icons/post_job_icon.svg',
            ),
            activeIcon: buildCustomIcon(
              context,
              'assets/icons/post_job_selected.svg',
            ),
            label: "Post Job",
          ),
          BottomNavigationBarItem(
            icon: buildCustomIcon(
              context,
              'assets/icons/search_icon.svg',
            ),
            activeIcon: buildCustomIcon(
              context,
              'assets/icons/search_icon_selected.svg',
              color: ThemeColors.searchBarSecondaryThemeColor,
            ),
            label: AppLocalizations.of(context)!.searchJobs,
          ),
          BottomNavigationBarItem(
            icon: buildCustomIcon(
              context,
              'assets/icons/services_icon.svg',
            ),
            activeIcon: buildCustomIcon(
              context,
              'assets/icons/services_icon_selected.svg',
              color: ThemeColors.searchBarSecondaryThemeColor,
            ),
            label: AppLocalizations.of(context)!.services,
          ),
          BottomNavigationBarItem(
            icon: buildCustomIcon(
              context,
              'assets/icons/path_icon.svg',
            ),
            activeIcon: buildCustomIcon(
              context,
              'assets/icons/path_icon_selected.svg',
              color: ThemeColors.searchBarSecondaryThemeColor,
            ),
            label: AppLocalizations.of(context)!.path,
          ),
        ],
      ),
    );
  }

  Widget buildCustomIcon(context, src, {Color? color}) {
    return SvgPicture.asset(
      src,
      height: MediaQuery.of(context).size.height * 0.035,
      fit: BoxFit.contain,
      colorFilter:
          color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
