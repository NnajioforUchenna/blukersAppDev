import 'package:blukers/common_files/constants.dart';
import 'package:blukers/models/payment_model/active_subscription.dart';
import 'package:blukers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ActiveSubscriptionCard extends StatelessWidget {
  const ActiveSubscriptionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActiveSubscription? activeSubscription;
    UserProvider up = Provider.of<UserProvider>(context);
    if (up.appUser != null) {
      activeSubscription = up.appUser!.activeSubscription;
    }
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Your Active Subscription',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ),
        Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: activeSubscription == null
              ? const Center(
                  child: Text('No Active Subscription to Display'),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.badge, color: Colors.grey),
                          SizedBox(width: 10),
                          Text('Subscription Name:',
                              style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(width: 10),
                          Text(activeSubscription.subscriptionName,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.date_range, color: Colors.grey),
                          SizedBox(width: 10),
                          Text('Subscribe Date:',
                              style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(width: 10),
                          Text(
                              formatDate(activeSubscription
                                  .subscribeDate), // replace with actual date
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.date_range, color: Colors.grey),
                          SizedBox(width: 10),
                          Text('Renew Date:',
                              style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(width: 10),
                          Text(
                              formatDate(activeSubscription
                                  .renewDate), // replace with actual date
                              style: GoogleFonts.montserrat(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.money, color: Colors.grey),
                          SizedBox(width: 10),
                          Text('Amount:',
                              style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(width: 10),
                          Text(
                              activeSubscription.amountPaid
                                  .toString(), // replace with actual amount
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
        )
      ],
    );
  }
}
