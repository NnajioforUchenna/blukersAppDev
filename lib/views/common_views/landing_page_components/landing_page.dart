import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/styles/index.dart';
import 'option_box.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // First and Second sections combined: Logo/Image and Slogan
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.asset(
                'assets/images/looking_for_you.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Transform.translate(
              offset: const Offset(0, -60),
              child: const Text(
                "Dream. Build. Connect.",
                textAlign: TextAlign.center,
                style: ThemeTextStyles.landingPageSubtitleThemeTextStyle,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Third section: Question to the user
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "What are you seeking?",
                textAlign: TextAlign.center,
                style: ThemeTextStyles.landingPageQuestionThemeTextStyle,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Fourth section: Two boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First box
                OptionBox(
                    imgSrc: 'assets/images/worker_icon.png',
                    title: "A Job",
                    onTap: () {
                      up.userRole = "worker";
                      Navigator.pushNamed(context, '/jobs');
                    }),
                // Space between boxes
                const SizedBox(width: 20),
                // Second box
                OptionBox(
                  imgSrc: 'assets/images/company_icon.png',
                  title: "Workers",
                  onTap: () {
                    up.userRole = "company";
                    Navigator.pushNamed(context, '/workers');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
