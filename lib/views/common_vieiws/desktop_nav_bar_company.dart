import 'package:auto_size_text/auto_size_text.dart';
import 'package:blukers/providers/app_settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../providers/user_provider_parts/user_provider.dart';
import '../../services/responsive.dart';
import '../../utils/styles/theme_colors.dart';
import 'navbar_widgets.dart';

class DesktopNavBarCompany extends StatefulWidget
    implements PreferredSizeWidget {
  const DesktopNavBarCompany({super.key});

  @override
  State<DesktopNavBarCompany> createState() => _DesktopNavBarCompanyState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 25);
}

class _DesktopNavBarCompanyState extends State<DesktopNavBarCompany> {
  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 4),
            blurRadius: 9.2,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 65,
            width: 132,
            child: Image.asset('assets/images/blukers_logo.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const NavbarItem(title: "Worker's Home", route: '/workers'),
              const NavbarItem(
                title: "Services",
                route: '/workerOffers',
              ),
              const NavbarItem(
                title: "Create Job Post",
                route: '/createJobPost',
              ),
              const NavbarItem(
                title: "Path to Employing a Worker",
                route: '/pathToEmployingWorker',
              ),
              const SizedBox(
                height: 40,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: VerticalDivider(
                    color: Color.fromRGBO(226, 230, 233, 1),
                    thickness: 1,
                    width: 1,
                  ),
                ),
              ),
              up.appUser == null
                  ? Showcase(
                      key: asp.signInButton,
                      description: 'Use this button to sign in to your account',
                      overlayOpacity: 0.6,
                      targetShapeBorder: const CircleBorder(),
                      tooltipBackgroundColor:
                          const Color.fromRGBO(30, 117, 187, 1),
                      descTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      child: SizedBox(
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColors.primaryThemeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: AutoSizeText(
                            'Sign in',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const ProfileNavBarDesktop()
            ],
          )
        ],
      ),
    );
  }
}

class ProfileNavBarDesktop extends StatelessWidget {
  const ProfileNavBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return PopupMenuButton<int>(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      color: Colors.white,
      position: PopupMenuPosition.under,
      offset: Offset(Responsive.isDesktop(context) ? 20 : 80, 45),
      shape: const TooltipShape(),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          enabled: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ThemeColors.primaryThemeColor),
                  width: 24,
                  height: 24,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: up.appUser!.photoUrl != null &&
                            up.appUser!.photoUrl != ""
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.jpeg",
                            image: up.appUser!.photoUrl!,
                            fit: BoxFit.cover,
                          )
                        : FittedBox(
                            fit: BoxFit.fill,
                            child: Image.asset(
                                "assets/images/userDefaultProfilePic.png"),
                          ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        up.appUser!.getCompanyName,
                        style: GoogleFonts.montserrat(
                          color: ThemeColors.black1ThemeColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem<int>(
          enabled: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Text(
                  "Switch to Worker",
                  style: GoogleFonts.montserrat(
                    color: ThemeColors.black1ThemeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                SizedBox(
                  height: 16,
                  width: 28,
                  child: Transform.scale(
                    scale: .5,
                    child: CupertinoSwitch(
                      trackColor: ThemeColors.secondaryThemeColor,
                      value: false,
                      activeColor: ThemeColors.primaryThemeColor,
                      onChanged: (value) {
                        Navigator.of(context).pop();
                        up.setUserRole("worker");

                        context.go("/jobs");
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        PopupMenuItem<int>(
          enabled: false,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromRGBO(242, 242, 247, 1), width: 1),
                    top: BorderSide(
                        color: Color.fromRGBO(242, 242, 247, 1), width: 1))),
            child: const Column(
              children: [
                OverlayRow(
                  route: '/companyChat',
                  title: "Chat With Potential Employees",
                  icon: "assets/icons/chat.svg",
                ),
                OverlayRow(
                  route: '/myJobPosts',
                  title: "My Workers",
                  icon: "assets/icons/saved.svg",
                ),
              ],
            ),
          ),
        ),
        const PopupMenuItem<int>(
          enabled: false,
          child: OverlayRow(
            route: '/companyProfile',
            title: "Company Profile",
            icon: "assets/icons/profile.svg",
          ),
        )
      ],
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Responsive.isDesktop(context)
                ? null
                : Border.all(
                    width: 2,
                    color: ThemeColors.secondaryThemeColor,
                  )),
        width: 28,
        height: 28,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: up.appUser!.photoUrl != null && up.appUser!.photoUrl != ""
              ? FadeInImage.assetNetwork(
                  placeholder: "assets/images/loading.jpeg",
                  image: up.appUser!.photoUrl!,
                  fit: BoxFit.cover,
                )
              : FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset("assets/images/userDefaultProfilePic.png"),
                ),
        ),
      ),
    );
  }
}
