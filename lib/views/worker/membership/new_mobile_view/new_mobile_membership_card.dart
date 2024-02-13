import 'package:blukers/views/worker/membership/new_mobile_view/show_membership_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import 'active_indicator_widget.dart';
import 'amount_display_widget.dart';
import 'diagonal_shape.dart';
import 'mobile_membership_details_widget.dart';

class NewMobileMembershipCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String amount;
  final String subscriptionId;
  final List<String> details;
  const NewMobileMembershipCard(
      {super.key,
      required this.color,
      required this.title,
      required this.amount,
      required this.subtitle,
      required this.subscriptionId,
      required this.details});

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
            builder: (context) => ShowMembershipDetailsDialog(
                  membership: MobileMembershipDetailsWidget(
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
      child: Stack(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: color,
            child: Container(
              height: height * 0.15,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: title.toUpperCase() + " ",
                              style: GoogleFonts.montserrat(
                                fontSize: 28.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (subtitle != '')
                              TextSpan(
                                text: subtitle
                                    .toUpperCase(), // Added a newline for separation
                                style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      Container(
                        margin: const EdgeInsets.only(right: 20.0),
                        child: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: ActiveIndicatorWidget(isActive: isActive),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: DiagonalShape(
              height: height * 0.1,
              width: width * 0.4,
            ), // Replace with the widget you want to position
          ),
          Positioned(
            bottom: 20,
            left: 25,
            child: AmountDisplayWidget(
              amount: amount,
              color: color,
            ), // Replace with the widget you want to position
          ),
        ],
      ),
    );
  }
}
