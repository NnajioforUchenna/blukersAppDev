import 'package:blukers/providers/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/payments_provider.dart';
import 'carousel_with_cards.dart';
import 'manageMembershipButton.dart';

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
    UserProvider up = Provider.of<UserProvider>(context);
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
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  // const Expanded(
                  //   flex: 2,
                  //   child: SizedBox(),
                  // )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Apply without any restrictions',
                textAlign: TextAlign.start,
                style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 18.sp,
              ),
              Stack(
                children: <Widget>[
                  CarouselWithCards(),
                  if (up.appUser != null && up.appUser!.isSubscriptionActive)
                    const Positioned(
                      bottom: 200,
                      left: 0,
                      right: 0,
                      child: Center(child: ManageMembershipButton()),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
