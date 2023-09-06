import 'package:blukers/services/stripe_data.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/membership/mobile_view/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/payments_provider.dart';
import 'carousel_with_cards.dart';
import 'my_evelated_button.dart';

class MobileMembershipWidget extends StatefulWidget {
  const MobileMembershipWidget({super.key});

  @override
  State<MobileMembershipWidget> createState() => _MobileMembershipWidgetState();
}

class _MobileMembershipWidgetState extends State<MobileMembershipWidget> {
  late PaymentsProvider pp;

  @override
  void initState() {
    pp = Provider.of<PaymentsProvider>(context, listen: false);
    pp.appleInitialize();
    super.initState();
  }

  @override
  void dispose() {
    pp.appleDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PaymentsProvider pp = Provider.of<PaymentsProvider>(context);
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
        iconTheme: const IconThemeData(
          color: ThemeColors.primaryThemeColor,
        ),
        elevation: 0,
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
              if (!pp.isActiveMember)
                MyElevatedButton(
                  firstText: 'Premium',
                  secondText: '',
                  thirdText: '\$4.99/Monthly',
                  onPress: () async {
                    pp.pay4Subscription(context, 'premium');
                  },
                ),
              SizedBox(
                height: 18.sp,
              ),
              if (!pp.isActiveMember)
                MyElevatedButton(
                  firstText: 'Premium',
                  secondText: 'Plus',
                  thirdText: '\$9.99/Monthly',
                  onPress: () async {
                    pp.pay4Subscription(context, 'premiumPlus');
                  },
                ),
              SizedBox(
                height: 18.sp,
              ),
              if (pp.isActiveMember)
                Center(
                  child: InkWell(
                    onTap: () async {
                      var url = await getCustomerPortalUrl();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CheckoutScreen(url: url);
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
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
  }
}
