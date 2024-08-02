import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'diagonally_cut_rounded_rectangle.dart';

class MobileMembershipCard extends StatelessWidget {
  final String headerTitle;
  final String headerSubtitle;
  final String bodyTitle;
  final String bodySubtitle;
  final bool isNormalArrangement;
  final Color color;
  const MobileMembershipCard(
      {super.key,
      required this.headerTitle,
      required this.headerSubtitle,
      required this.bodyTitle,
      required this.bodySubtitle,
      required this.isNormalArrangement,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40.h,
      width: MediaQuery.of(context).size.width * 0.75.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          color: color,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    const Center(
                      child: DiagonallyCutRoundedRectangle(),
                    ),
                    Positioned(
                      right: 10, // Adjust for desired padding
                      top: 10, // Adjust for desired padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            headerTitle.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            headerSubtitle,
                            style: GoogleFonts.montserrat(
                                color: Colors.black, fontSize: 20.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !isNormalArrangement
                        ? Text(bodySubtitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.white, fontSize: 20.sp))
                        : const SizedBox(),
                    Text(bodyTitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700)),
                    isNormalArrangement
                        ? Text(bodySubtitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.white, fontSize: 20.sp))
                        : const SizedBox(),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
