import '../../../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../../../services/stripe_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'desktop_membership_card.dart';

class DesktopCards extends StatelessWidget {
  final StripeData stripeData;
  final SubscriptionStatus subscriptionStatus;

  const DesktopCards(
      {super.key, required this.stripeData, required this.subscriptionStatus});
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (subscriptionStatus.subIsActive == false)
            DesktopMembershipCard(
              headerTitle: 'Free',
              headerSubtitle: '',
              amount: '\$0',
              period: '',
              features: const [
                '',
                'Create your Resume',
                'Apply to 2 Jobs Daily'
              ],
              color: const Color(0xffF29500),
              onPress: () {},
              isSubscribed: false,
            ),
          if (subscriptionStatus.subIsActive == false ||
              (subscriptionStatus.subIsActive &&
                  subscriptionStatus.activePriceId ==
                      stripeData.employeePremiumPriceId))
            DesktopMembershipCard(
              headerTitle: 'Premium',
              headerSubtitle: '',
              amount: '\$4.99/',
              period: 'monthly',
              features: const [
                'Create your Resume',
                'Upload your Resume',
                'Upload your Certifications',
                'Apply to 10 Jobs Daily',
                'Show your Profile on Top in Employers Searchers Section',
              ],
              color: const Color(0xff1a75bb),
              isSubscribed: subscriptionStatus.subIsActive,
              onPress: () async {
                print("premium");
                if (subscriptionStatus.subIsActive) {
                  var url = await getCustomerPortalUrl();
                  launchUrl(Uri.parse(url));
                } else {
                  DocumentReference docRef = await setCheckoutSession(
                      up.appUser!.uid, stripeData.employeePremiumPriceId);

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
                          print("error: $error");
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
                }
              },
            ),
          if (subscriptionStatus.subIsActive == false ||
              (subscriptionStatus.subIsActive &&
                  subscriptionStatus.activePriceId ==
                      stripeData.employeePremiumPlusPriceId))
            DesktopMembershipCard(
              headerTitle: 'Premium',
              headerSubtitle: 'Plus',
              amount: '\$19.99/',
              period: 'monthly',
              features: const [
                'All Premium Feastures (*)',
                'Apply to Unlimited Jobs',
                'Display your immigration verified status so you can work internationally',
                'Get Employment Verfied',
              ],
              color: const Color(0xffF16523),
              isSubscribed: subscriptionStatus.subIsActive,
              onPress: () async {
                print("premium plus");
                if (subscriptionStatus.subIsActive) {
                  var url = await getCustomerPortalUrl();
                  launchUrl(Uri.parse(url));
                } else {
                  DocumentReference docRef = await setCheckoutSession(
                      up.appUser!.uid, stripeData.employeePremiumPlusPriceId);
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
                          print("error: $error");
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
                }
                print("data set");
              },
            ),
        ],
      ),
    );
  }
}
