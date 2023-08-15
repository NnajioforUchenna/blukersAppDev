import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'carousel_with_cards.dart';
import 'my_evelated_button.dart';

class MobileMembershipWidget extends StatelessWidget {
  const MobileMembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
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
            const MyElevatedButton(
              firstText: 'Premium',
              secondText: '',
              thirdText: '\$4.99/Monthly',
            ),
            SizedBox(
              height: 18.sp,
            ),
            const MyElevatedButton(
              firstText: 'Premium',
              secondText: 'Plus',
              thirdText: '\$19.99/Monthly',
            ),
            SizedBox(
              height: 18.sp,
            ),
            Center(
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                  child: Text('Skip',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
