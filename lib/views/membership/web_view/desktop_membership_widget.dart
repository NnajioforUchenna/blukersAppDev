import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/services/stripe_data.dart';
import 'package:bulkers/views/membership/mobile_view/carousel_with_cards.dart';
import 'package:bulkers/views/membership/mobile_view/checkout_screen.dart';
import 'package:bulkers/views/membership/mobile_view/my_evelated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'desktop_cards.dart';

class DesktopMembershipWidget extends StatelessWidget {
  const DesktopMembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return FutureBuilder<StripeData>(
        future: fetchStripeData(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: Text("Loading Stripe Data"));
          }
          StripeData stripeData = snapshot.data!;
          print(stripeData.employeePremiumPlusPriceId);
          print(up.appUser!.uid);
          return StreamBuilder<SubscriptionStatus>(
              stream: checkSubscriptionStatus(up.appUser!.uid, stripeData),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return Center(child: Text("Loading Stripe Data"));
                }
                SubscriptionStatus subscriptionStatus = snapshot.data!;
                print(subscriptionStatus.subIsActive);
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Subscriptions"),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Apply to Unlimited Jobs',
                              style: GoogleFonts.montserrat(
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Apply without any restrictions',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 18.sp,
                          ),
                          DesktopCards(
                            stripeData: stripeData,
                            subscriptionStatus: subscriptionStatus,
                          ),
                          SizedBox(
                            height: 18.sp,
                          ),
                          SizedBox(
                            height: 18.sp,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50.h, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300],
                                ),
                                child: Text('Skip',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
