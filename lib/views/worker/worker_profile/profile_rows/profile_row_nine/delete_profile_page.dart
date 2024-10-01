import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../services/responsive.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../../../old_common_views/components/confirmation_dialog.dart';
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 56,
        bottom: 56,
        left: Responsive.isMobile(context) ? 25 : 40,
        right: Responsive.isMobile(context) ? 25 : 40,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Delete account?',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFBC0101),
                    fontSize: Responsive.isMobile(context) ? 20 : 29),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
              "Before we delete your data, please we'll need you to answer a few questions.",
              style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFC3AEAE))),
          SizedBox(
            height: Responsive.isMobile(context) ? 56 : 80,
          ),
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
                        builder: (context) => const WhereDoYouResidePage());
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
                        builder: (context) => const WhyDeleteAccountPage());
                  },
                ),
              )
            ],
          ),
          const Spacer(),
          Center(
        
            child: ElevatedButton(
              onPressed: () async {
                     if(whyDeleteAccount && whereDoYouReside){
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
                    }
                 ,
                style: ElevatedButton.styleFrom(
                    backgroundColor:whyDeleteAccount && whereDoYouReside
                  ?  ThemeColors.primaryThemeColor :ThemeColors.primaryThemeColor.withOpacity(.5) ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: Responsive.isMobile(context) ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
