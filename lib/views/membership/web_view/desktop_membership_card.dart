import 'package:blukers/views/membership/web_view/web_diagonally_cut_rounded_rectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DesktopMembershipCard extends StatelessWidget {
  final String headerTitle;
  final String headerSubtitle;
  final String amount;
  final String period;
  final List<String> features;
  final Color color;
  final VoidCallback onPress;
  final bool isSubscribed;
  const DesktopMembershipCard(
      {super.key,
      required this.headerTitle,
      required this.headerSubtitle,
      required this.amount,
      required this.period,
      required this.features,
      required this.color,
      required this.isSubscribed,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.27,
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
                children: [
                  Stack(
                    children: [
                      WebDiagonallyCutRoundedRectangle(),
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$amount',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: period,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.2), // Slightly transparent black color
                      borderRadius: BorderRadius.circular(20), // Rounded edges
                    ),
                    padding: EdgeInsets.all(50),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              List<Widget>.generate(features.length, (index) {
                            return features[index].isEmpty
                                ? const SizedBox()
                                : RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '• ',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                          ), // Style for the bullet point
                                        ),
                                        TextSpan(
                                          text: features[index],
                                          style: index % 2 == 0
                                              ? GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w700,
                                                ) // Style for even indexes
                                              : GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 11.sp,
                                                ), // Style for odd indexes
                                        ),
                                      ],
                                    ),
                                  );
                          }),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom:
              0, // Aligns the bottom of the custom choice chip with the bottom of the container
          child: InkWell(
            onTap: onPress,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: Text(isSubscribed ? 'Manage' : 'Continue',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
