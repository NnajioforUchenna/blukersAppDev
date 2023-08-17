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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text('Apply to Unlimited Jobs',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 23.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ),
                              const Expanded(
                                flex: 2,
                                child: SizedBox(),
                              )
                            ],
                          ),
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
                          CarouselWithCards(),
                          SizedBox(
                            height: 18.sp,
                          ),
                          if (subscriptionStatus.subIsActive == false)
                            MyElevatedButton(
                              firstText: 'Premium',
                              secondText: '',
                              thirdText: '\$4.99/Monthly',
                              onPress: () async {
                                print("premium");

                                DocumentReference docRef =
                                    await setCheckoutSession(up.appUser!.uid,
                                        stripeData.employeePremiumPriceId);

                                docRef.snapshots().listen(
                                  (ds) {
                                    if (ds.exists) {
                                      var error;
                                      try {
                                        error = ds.get("error");
                                      } catch (e) {
                                        error = null;
                                      }
                                      if (error != null) {
                                        print("error: " + error.toString());
                                      } else {
                                        try {
                                          String url = ds.get("url");

                                          launchUrl(Uri.parse(url));
                                        } catch (error) {
                                          print(error);
                                        }
                                      }
                                    }
                                  },
                                );
                                print("data set");
                              },
                            ),
                          SizedBox(
                            height: 18.sp,
                          ),
                          if (subscriptionStatus.subIsActive == false)
                            MyElevatedButton(
                              firstText: 'Premium',
                              secondText: 'Plus',
                              thirdText: '\$19.99/Monthly',
                              onPress: () async {
                                print("premium plus");
                                DocumentReference docRef =
                                    await setCheckoutSession(up.appUser!.uid,
                                        stripeData.employeePremiumPlusPriceId);
                                docRef.snapshots().listen(
                                  (ds) {
                                    if (ds.exists) {
                                      var error;
                                      try {
                                        error = ds.get("error");
                                      } catch (e) {
                                        error = null;
                                      }
                                      if (error != null) {
                                        print("error: " + error.toString());
                                      } else {
                                        try {
                                          String url = ds.get("url");

                                          launchUrl(Uri.parse(url));
                                        } catch (error) {
                                          print(error);
                                        }
                                      }
                                    }
                                  },
                                );
                                print("data set");
                              },
                            ),
                          SizedBox(
                            height: 18.sp,
                          ),
                          if (subscriptionStatus.subIsActive)
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  var url = await getCustomerPortalUrl();

                                  launchUrl(Uri.parse(url));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[300],
                                  ),
                                  child: Text('Manage Your Subscription',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 14,
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
