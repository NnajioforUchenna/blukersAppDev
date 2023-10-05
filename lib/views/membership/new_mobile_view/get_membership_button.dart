import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/payments_provider.dart';
import '../../../providers/user_provider.dart';

class GetMembershipButton extends StatelessWidget {
  final String subscriptionId;
  final Color color;
  const GetMembershipButton(
      {super.key, required this.subscriptionId, required this.color});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    PaymentsProvider pp = Provider.of<PaymentsProvider>(context);
    String buttonText = up.getButton(subscriptionId);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.025,
      width: width * 0.28,
      margin: EdgeInsets.only(top: height * 0.03, bottom: 30.0),
      child: ElevatedButton(
        onPressed: () {
          pp.determineAction(context, buttonText, subscriptionId);
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: buttonText == "Active" ? Colors.green : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          buttonText,
          style: GoogleFonts.montserrat(
            color: buttonText == "Active" ? Colors.white : color,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
