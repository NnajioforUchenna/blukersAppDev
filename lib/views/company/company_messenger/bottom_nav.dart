import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/company/Alert/job_alert.dart';
import 'package:blukers/views/company/company_chat/company_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../providers/app_settings_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/theme_colors.dart';

class CompanyMessengerNavigationBar extends StatefulWidget {
  const CompanyMessengerNavigationBar({super.key});

  @override
  State<CompanyMessengerNavigationBar> createState() =>
      _CompanyMessengerNavigationBarState();
}

class _CompanyMessengerNavigationBarState
    extends State<CompanyMessengerNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    currentPageIndex = up.messengerIndex;
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    List<Widget> body = [
       JobAlertList(),
      const CompanyChat(),
      const SizedBox(),
      const SizedBox(),
    ];
    return Scaffold(
      body: body[currentPageIndex],
      bottomNavigationBar: Responsive.isDesktop(context) ? null : Showcase(
        key: asp.bottomNavigationMessenger,
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
            up.navigateMessenger(context, index);
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
                'assets/icons/alert.svg',
              ),
              activeIcon: buildCustomIcon(
                context,
                'assets/icons/alert.svg',
              ),
              label: "Alerts",
            ),
            BottomNavigationBarItem(
              icon: buildCustomIcon(
                context,
                'assets/icons/messages.svg',
              ),
              activeIcon: buildCustomIcon(
                context,
                'assets/icons/messages.svg',
              ),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: buildCustomIcon(
                context,
                'assets/icons/calls.svg',
              ),
              activeIcon: buildCustomIcon(
                context,
                'assets/icons/calls.svg',
                color: ThemeColors.searchBarSecondaryThemeColor,
              ),
              label: "Calls",
            ),
            BottomNavigationBarItem(
              icon: buildCustomIcon(
                context,
                'assets/icons/settings.svg',
              ),
              activeIcon: buildCustomIcon(
                context,
                'assets/icons/settings.svg',
                color: ThemeColors.searchBarSecondaryThemeColor,
              ),
              label: "Settings",
            ),
          ],
        ),
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
