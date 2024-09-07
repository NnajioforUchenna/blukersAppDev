import 'package:blukers/views/auth/common_widget/dashed_seperator.dart';
import 'package:blukers/views/auth/login/components/sign_in_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/theme_colors.dart';

class SignInOptions extends StatefulWidget {
  const SignInOptions({
    super.key,
  });

  @override
  State<SignInOptions> createState() => _SignInOptionsState();
}

class _SignInOptionsState extends State<SignInOptions> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: DashedSeperator(
              dashWidth: 3,
              color: ThemeColors.black1ThemeColor.withOpacity(.30),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "Or Continue With",
                style: GoogleFonts.montserrat(
                  color: ThemeColors.black1ThemeColor.withOpacity(.30),
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
                child: DashedSeperator(
              dashWidth: 3,
              color: ThemeColors.black1ThemeColor.withOpacity(.30),
            )),
          ],
        ),
        const SizedBox(
          height: 26,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInOptionsWidget(
              icon: "assets/icons/logo_google.svg",
              label: "Google",
              onPressed: () {
                up.signInWithGoogle(context);
              },
            ),
            const SizedBox(width: 24),
            SignInOptionsWidget(
              icon: "assets/icons/logo_facebook.svg",
              onPressed: () {
                up.signInWithFacebook(context);
              },
              label: "Facebook",
            ),
            // const SizedBox(width: 10),
            // // SignInOptionsWidget(
            // //   icon: FontAwesomeIcons.apple,
            // //   onPressed: () {
            // //     up.signInWithApple(context);
            // //   },
            // //   color: Colors.grey.shade800,
            // // ),
          ],
        ),
      ],
    );
  }
}
