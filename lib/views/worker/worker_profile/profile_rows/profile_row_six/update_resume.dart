import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../old_common_views/small_pop_button_widget.dart';
import '../../profile_menu_button.dart';
import '../profile_row_three/profile_row_three.dart';
import '../profile_row_two/profile_row_two.dart';
import 'build_your_resume.dart';
import 'upload_your_resume.dart';

class UpdateResume extends StatelessWidget {
  const UpdateResume({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding:
          const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 80),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: height * 0.04, bottom: height * 0.05),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  child: Text(
                    'Resume',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                const ProfileRowTwo(),
                const ProfileRowThree(),
                ProfileMenuButton(
                  text: "Upload your Resume",
                  onPress: () {
                    showDialog(
                        context: context,
                        builder: (context) => const UploadYourResume());
                  },
                ),
                SizedBox(height: height * 0.02),
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
          ),
          const Positioned(
            top: 10, // Adjust as needed
            left: 10, // Adjust as needed
            child: SmallPopButtonWidget(),
          ),
        ],
      ),
    );
  }
}
