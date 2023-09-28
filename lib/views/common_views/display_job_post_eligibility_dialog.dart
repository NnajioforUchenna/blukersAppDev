import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../membership/show_subscription_dialog.dart';

class DisplayJobPostEligibilityDialog extends StatelessWidget {
  const DisplayJobPostEligibilityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive design
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserProvider up = Provider.of<UserProvider>(context);
    String subscriptionType =
        up.appUser?.activeSubscription?.subscriptionId ?? '';
    String numberOfJobsAppliedToday = up
            .appUser?.jobApplicationTracker?.numberOfAppliedJobsToday
            .toString() ??
        '0';
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
      child: Container(
        width: width * 0.9,
        height: height * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Subscription: $subscriptionType",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "You've applied for $numberOfJobsAppliedToday jobs today.",
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Based on your current subscription, you can't apply for more jobs today.",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.redAccent,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Upgrade your subscription for more benefits!",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Spacer between text and button
            Row(
              children: [
                const Spacer(), // Spacer between button and text
                SizedBox(
                  width: width * 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) => const showSubscriptionDialog());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ThemeColors.secondaryThemeColor, // Background color

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Upgrade Subscription',
                        style: GoogleFonts.montserrat(
                            fontSize: 16, color: Colors.white)),
                  ),
                ),
                const Spacer(), // Spacer between button and text
              ],
            ),
          ],
        ),
      ),
    );
  }
}
