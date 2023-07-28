import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
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
            Transform.translate(
              offset: const Offset(0, -60),
              child: const Text(
                "Bulkers: Bridging Blue Collars Worldwide!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // Third section: Question to the user
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("What are you seeking?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ebGaramond(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            // Fourth section: Two boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // First box
                OptionBox(
                    icon: Icons.work,
                    title: "A Job",
                    onTap: () {
                      up.userType = "worker";
                      Navigator.pushNamed(context, '/jobs');
                    }),

                // Second box
                OptionBox(
                  icon: Icons.group,
                  title: "Workers",
                  onTap: () {
                    up.userType = "company";
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
