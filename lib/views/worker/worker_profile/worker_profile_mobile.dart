import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_eight/profile_row_eight.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_five/profile_row_five.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_four/profile_row_four.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_nine/profile_row_nine.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_seven/profile_row_seven.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_six/profile_row_six.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_three/profile_row_three.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_two/profile_row_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/company_chat_provider.dart';
import '../../../providers/user_provider_parts/user_provider.dart';
import '../../../services/responsive.dart';
import '../../old_common_views/components/app_version_display.dart';
import '../../old_common_views/components/confirmation_dialog.dart';
import '../../old_common_views/components/profile/profile_menu_button.dart';

class WorkerProfileMobile extends StatelessWidget {
  final int index;
  final Function onTapDesktop;
  const WorkerProfileMobile(
      {super.key, required this.index, required this.onTapDesktop});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ProfileRowTwo(),
          const ProfileRowThree(),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
                onPressed: () {
                  onTapDesktop(0);
                },
                isSelected: index == 0,
                child: Text(
                  AppLocalizations.of(context)!.userInformation,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: index == 0 ? Colors.black : const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ))
          else
            const ProfileRowFour(),
          if (Responsive.isMobile(context)) const SizedBox(height: 16),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
                onPressed: () {
                  onTapDesktop(1);
                },
                isSelected: index == 1,
                child: Text(
                  AppLocalizations.of(context)!.industriesSlashJobs,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: index == 1 ? Colors.black : const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ))
          else
            const ProfileRowFive(),
          if (Responsive.isMobile(context)) const SizedBox(height: 16),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
                onPressed: () {
                  onTapDesktop(2);
                },
                isSelected: index == 2,
                child: Text(
                  "Resume",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: index == 2 ? Colors.black : const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ))
          else
            const ProfileRowSix(),
          if (Responsive.isMobile(context)) const SizedBox(height: 16),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
                onPressed: () {
                  onTapDesktop(3);
                },
                isSelected: index == 3,
                child: Text(
                  AppLocalizations.of(context)!.subscriptions,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: index == 3 ? Colors.black : const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ))
          else
            const ProfileRowSeven(),
          if (Responsive.isMobile(context)) const SizedBox(height: 16),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
                onPressed: () {
                  onTapDesktop(4);
                },
                isSelected: index == 4,
                child: Text(
                  AppLocalizations.of(context)!.orders,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: index == 4 ? Colors.black : const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ))
          else
            const ProfileRowEight(),
          const SizedBox(height: 36),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
                onPressed: () {
                  CompanyChatProvider chatProvider =
                      Provider.of<CompanyChatProvider>(context, listen: false);
                  UserProvider up =
                      Provider.of<UserProvider>(context, listen: false);

                  confirmationDialog(
                    context: context,
                    stringsTemplate: 'logout',
                    onConfirm: () async {
                      chatProvider.clearGroups();
                      await up.signOut();
                      context.go('/');
                    },
                  );
                },
                isSelected: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Log out",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: const Color(0xFF757575),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(
                      Icons.logout,
                      size: 30.0,
                      color: Color(0xFF595959),
                    ),
                  ],
                ))
          else
            ProfileMenuButton(
              text: "Log out",
              trailing: const Icon(
                Icons.logout,
                size: 25.0,
                color: Color(0xFF595959),
              ),
              onPress: () {
                CompanyChatProvider chatProvider =
                    Provider.of<CompanyChatProvider>(context, listen: false);
                UserProvider up =
                    Provider.of<UserProvider>(context, listen: false);

                confirmationDialog(
                  context: context,
                  stringsTemplate: 'logout',
                  onConfirm: () async {
                    chatProvider.clearGroups();
                    await up.signOut();
                    context.go('/');
                  },
                );
              },
            ),
          if (Responsive.isMobile(context)) const SizedBox(height: 16),
          if (Responsive.isDesktop(context))
            DesktopMenuButton(
                onPressed: () {
                  onTapDesktop(5);
                },
                isSelected: index == 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.deleteAccount,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: const Color(0xFFC85E5E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/delete_icon.svg",
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFFC85E5E), BlendMode.srcIn),
                    ),
                  ],
                ))
          else
            const ProfileRowNine(),
          if (Responsive.isMobile(context)) const SizedBox(height: 16),
          const AppVersionDisplay(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
