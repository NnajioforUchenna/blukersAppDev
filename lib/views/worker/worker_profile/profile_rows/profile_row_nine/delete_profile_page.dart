import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../services/responsive.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../../../old_common_views/components/confirmation_dialog.dart';
import '../../../../old_common_views/small_pop_button_widget.dart';
import 'custom_check_box.dart';
import 'question_button.dart';
import 'where_do_you_reside.dart';
import 'why_delete_account_page.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    bool whereDoYouReside = up.getWhereDoYouReside();
    bool whyDeleteAccount = up.getWhyDeleteAccount().length > 20;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding:
          const EdgeInsets.only(left: 5, right: 5, top: 26, bottom: 80),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
                top: height * 0.01,
                bottom: height * 0.05,
                right: width * 0.07,
                left: width * 0.1),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.05, bottom: height * 0.02),
                  child: Text(
                    'Delete Account',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Text(
                    "Before we delete your data, please we'll need you to answer a few questions.",
                    style: GoogleFonts.montserrat(
                        fontSize: 12, fontWeight: FontWeight.w400)),
                SizedBox(height: height * 0.04),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomCheckbox(value: whereDoYouReside),
                    Expanded(
                      child: QuestionButton(
                        text: "Where do you reside?",
                        onPress: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  const WhereDoYouResidePage());
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomCheckbox(value: whyDeleteAccount),
                    Expanded(
                      child: QuestionButton(
                        text: "Why are you deleting your account?",
                        onPress: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  const WhyDeleteAccountPage());
                        },
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  height: height * 0.04,
                  width: width * 0.4,
                  margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
                  child: ElevatedButton(
                    onPressed: whyDeleteAccount && whereDoYouReside
                        ? () async {
                            confirmationDialog(
                              context: context,
                              stringsTemplate: 'deleteAccount',
                              onConfirm: () async {
                                await up.deleteUser(up.appUser!.uid);
                                Navigator.of(context).pop();
                                context.push('/');
                              },
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: ThemeColors.secondaryThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Delete Account',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: Responsive.isMobile(context) ? 10.sp : 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
