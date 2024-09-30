import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../services/responsive.dart';
import '../../../../old_common_views/components/profile/profile_menu_button.dart';
import 'build_your_resume.dart';
import 'upload_your_resume.dart';

class UpdateResume extends StatelessWidget {
  const UpdateResume({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(
        top: 56,
        bottom: 56,
        left: Responsive.isMobile(context) ? 25 : 40,
        right: Responsive.isMobile(context) ? 25 : 40,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: Responsive.isMobile(context)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                'Resume',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.isMobile(context) ? 20 : 29),
              ),
            ],
          ),
          const SizedBox(
            height: 56,
          ),
          // const ProfileRowTwo(),
          // const ProfileRowThree(),
          ProfileMenuButton(
            text: "Upload your Resume",
            onPress: () {
              showDialog(
                  context: context,
                  builder: (context) => const UploadYourResume());
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileMenuButton(
            text: "Build your Resume",
            onPress: () {
              showDialog(
                  context: context,
                  builder: (context) => const BuildYourResume());
            },
          )
        ],
      ),
    );
  }
}
