import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'get_membership_button.dart';

class MobileMembershipDetailsWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String amount;
  final String subscriptionId;
  final List<String> details;
  const MobileMembershipDetailsWidget(
      {super.key,
      required this.color,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.subscriptionId,
      required this.details});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: height * 0.30,
              margin: EdgeInsets.only(
                  top: height * 0.08,
                  left: 20.0,
                  right: 20.0,
                  bottom: height * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          color: Colors.grey[800],
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle.toUpperCase(),
                        style: GoogleFonts.montserrat(
                          color: Colors.grey[800],
                          fontSize: 30.0,
                        ),
                      ),
                    Text(
                      "\$$amount",
                      style: GoogleFonts.montserrat(
                          color: color,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'monthly',
                      style: GoogleFonts.montserrat(
                        color: color,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List<Widget>.generate(
                  details.length,
                  (index) => Text(
                    details[index],
                    textAlign: TextAlign.center,
                    style: index % 2 == 0
                        ? GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ) // Style for even indexes
                        : GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                  ),
                ),
              ),
            ),
            GetMembershipButton(
              subscriptionId: subscriptionId,
              color: color,
            ),
            SizedBox(height: height * 0.1)
          ],
        ),
      ),
    );
  }
}
