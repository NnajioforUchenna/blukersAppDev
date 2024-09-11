import 'package:auto_size_text/auto_size_text.dart';
import 'package:blukers/providers/app_settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../providers/user_provider_parts/user_provider.dart';
import '../../utils/styles/theme_colors.dart';

class DesktopNavBar extends StatefulWidget implements PreferredSizeWidget {
  const DesktopNavBar({super.key});

  @override
  State<DesktopNavBar> createState() => _DesktopNavBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 25);
}

class _DesktopNavBarState extends State<DesktopNavBar> {
  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    final userRole = up.userRole;
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
              NavbarItem(
                  title: userRole == "company" ? "Worker's Home" : "Jobs",
                  route: userRole == "company" ? '/workers' : "/jobs"),
              const NavbarItem(
                title: "Services",
                route: '/workerOffers',
              ),
              userRole == "company"
                  ? const NavbarItem(
                      title: "Create Job Post",
                      route: '/createJobPost',
                    )
                  : const NavbarItem(
                      title: "Select By Industry",
                      route: '/selectJobs',
                    ),
              NavbarItem(
                title: userRole == "company"
                    ? "Path to Employing a Worker"
                    : "Path to Successuful Job",
                route: userRole == "company"
                    ? '/pathToEmployingWorker'
                    : '/pathToJob',
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
                  : PopupMenuButton<int>(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      color: Colors.white,
                      position: PopupMenuPosition.under,
                      offset: const Offset(20, 45),
                      shape: const TooltipShape(),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          enabled: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
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
                                            placeholder:
                                                "assets/images/loading.jpeg",
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
                                        userRole == "company"
                                            ? up.appUser!.getCompanyName
                                            : up.appUser!.displayName ??
                                                "-- --",
                                        style: GoogleFonts.montserrat(
                                          color: ThemeColors.ash,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Switch to ${userRole == "company" ? "Worker" : "Company"} Account",
                                  style: GoogleFonts.montserrat(
                                    color: ThemeColors.ash,
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
                                      trackColor:
                                          ThemeColors.secondaryThemeColor,
                                      value:
                                          userRole == "company" ? false : true,
                                      activeColor:
                                          ThemeColors.primaryThemeColor,
                                      onChanged: (value) {
                                        Navigator.of(context).pop();
                                        if (value) {
                                          up.setUserRole("worker");
                                          context.go("/jobs");
                                        } else {
                                          up.setUserRole("company");
                                          context.go("/workers");
                                        }
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
                                        color: Color.fromRGBO(242, 242, 247, 1),
                                        width: 1),
                                    top: BorderSide(
                                        color: Color.fromRGBO(242, 242, 247, 1),
                                        width: 1))),
                            child: Column(
                              children: [
                                userRole == "company"
                                    ? const OverlayRow(
                                        route: '/companyChat',
                                        title: "Chat With Potential Employees",
                                        icon: "assets/icons/chat.svg",
                                      )
                                    : const OverlayRow(
                                        route: '/workerMessages',
                                        title: "Job Alerts, Chats and Calls",
                                        icon: "assets/icons/notif.svg",
                                      ),
                                userRole == "company"
                                    ? const OverlayRow(
                                        route: '/myJobPosts',
                                        title: "My Workers",
                                        icon: "assets/icons/saved.svg",
                                      )
                                    : const OverlayRow(
                                        route: '/myJobs',
                                        title: "My Saved Jobs",
                                        icon: "assets/icons/saved.svg",
                                      ),
                                if (userRole == "worker")
                                  const OverlayRow(
                                    route: '/createResume',
                                    title: "My Resume",
                                    icon: "assets/icons/document.svg",
                                  ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem<int>(
                          enabled: false,
                          child: OverlayRow(
                            route: userRole == "company"
                                ? '/companyProfile'
                                : '/workerProfile',
                            title: userRole == "company"
                                ? "Company Profile"
                                : "Profile",
                            icon: "assets/icons/profile.svg",
                          ),
                        )
                      ],
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
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
                    )
            ],
          )
        ],
      ),
    );
  }
}

class OverlayRow extends StatelessWidget {
  final String route;
  final String title;
  final String icon;
  const OverlayRow({
    super.key,
    required this.route,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        context.go(route);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: GoogleFonts.montserrat(
                color: ThemeColors.ash,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavbarItem extends StatelessWidget {
  final String title;
  final String route;
  const NavbarItem({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        context.go(route);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: GoogleFonts.montserrat(
            color: ThemeColors.ash,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    const double arrowWidth = 50.0; 
    const double arrowHeight = 40.0; 

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - (arrowWidth + 10), 0);


    path.lineTo(rrect.width - (arrowWidth / 2 + 10), -arrowHeight); 
    path.lineTo(rrect.width - 10, 0); 

    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
