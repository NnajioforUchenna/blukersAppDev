import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'desktop_cards.dart';

class DesktopMembershipWidget extends StatelessWidget {
  const DesktopMembershipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: Column(
                    children: [
                      Text('Apply to Unlimited Jobs',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 17.w,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(
                        'Apply without any restrictions',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 8.w,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 50),
            DesktopCards(),
            const SizedBox(height: 50),
            Center(
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.h, vertical: 5),
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
    );
  }
}
