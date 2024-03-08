import '../../../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../../../services/stripe_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'desktop_cards.dart';

class DesktopSubscriptionWidget extends StatelessWidget {
  const DesktopSubscriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return FutureBuilder<StripeData>(
        future: fetchStripeData(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const Center(child: Text("Loading Stripe Data"));
          }
          StripeData stripeData = snapshot.data!;
          print(stripeData.employeePremiumPlusPriceId);
          print(up.appUser!.uid);
          return StreamBuilder<SubscriptionStatus>(
              stream: checkSubscriptionStatus(up.appUser!.uid, stripeData),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const Center(child: Text("Loading Stripe Data"));
                }
                SubscriptionStatus subscriptionStatus = snapshot.data!;
                print(subscriptionStatus.subIsActive);
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(
                            context); // This line pops the current route and goes back
                      },
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
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
                              onTap: () {
                                Navigator.pop(context);
                              },
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
