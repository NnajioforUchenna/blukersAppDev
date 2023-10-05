import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/payment_providers/payments_provider.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../membership/mobile_view/my_evelated_button.dart';
import 'products_carousel_cards.dart';

class MobileProductsWidget extends StatelessWidget {
  const MobileProductsWidget({super.key});

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
                    flex: 4,
                    child: Text('Services to Guarantee Your Employment',
                        style: GoogleFonts.montserrat(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  // const Expanded(
                  //   flex: 1,
                  //   child: SizedBox(),
                  // )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'These services are designed to help you get a job faster',
                textAlign: TextAlign.start,
                style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 18.sp,
              ),
              ProductsCarouselCards(),
              SizedBox(
                height: 18.sp,
              ),
              MyElevatedButton(
                firstText: 'FOIA',
                secondText: '',
                thirdText: '\$299.99 Service Fee',
                onPress: () async {
                  pp.pay4Services(context, 'foia');
                },
              ),
              SizedBox(
                height: 18.sp,
              ),
              MyElevatedButton(
                firstText: 'Employment',
                secondText: 'Verification',
                thirdText: '\$99.99 Service Fee',
                onPress: () async {
                  pp.pay4Services(context, 'employmentVerification');
                },
              ),
              SizedBox(
                height: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
