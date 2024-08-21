import 'package:blukers/services/responsive.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../providers/user_provider_parts/user_provider.dart';
import 'active_indicator_widget.dart';
import 'amount_display_widget.dart';
import 'diagonal_shape.dart';
import 'mobile_subscription_details_widget.dart';
import 'show_subscription_details_dialog.dart';

class MobileSubscriptionCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String buttonText;
  final String description;
  final String amount;
  final Color moreIconColor;

  final String subscriptionId;
  final List<String> details;

  const MobileSubscriptionCard({
    super.key,
    required this.color,
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.subscriptionId,
    required this.details,
    required this.description,
    required this.moreIconColor,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width * 0.95;
    UserProvider up = Provider.of<UserProvider>(context);
    bool isActive = up.whichMembership() == subscriptionId;

    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => ShowSubscriptionDetailsDialog(
                  membership: MobileSubscriptionDetailsWidget(
                    color: color,
                    title: title,
                    subtitle: subtitle,
                    amount: amount,
                    subscriptionId: subscriptionId,
                    details: details,
                  ),
                  color: color,
                ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF5F5F5), width: 1.9),
          // Black border
          borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                const Text(' '),
                Text(
                  subtitle,
                  style: GoogleFonts.montserrat(fontSize: 8),
                ),
                ActiveIndicatorWidget(isActive: isActive),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '\$$amount',
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 17),
            Row(
              children: [
                Text(
                  description,
                  style: GoogleFonts.montserrat(fontSize: 12),
                ),
                Icon(
                  Icons.add_box,
                  color: moreIconColor,
                  size: 15,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isActive ? Colors.transparent : Colors.blue,
                // Background color
                borderRadius: BorderRadius.circular(50.0),
                // Rounded corners
                border:
                    Border.all(color: Colors.blue, width: 1.5), // Blue border
              ),
              child: Center(
                child: Text(
                  buttonText,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.black : Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// Positioned(
// top: 0,
// left: 0,

// ),
