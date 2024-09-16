import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/styles/index.dart';

class LandingPageMobile extends StatefulWidget {
  const LandingPageMobile({super.key});

  @override
  State<LandingPageMobile> createState() => _LandingPageMobileState();
}

class _LandingPageMobileState extends State<LandingPageMobile> {
  bool isWorkerSelected = false;
  bool isCompanySelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.none,
        child: Column(
          children: [
            SizedBox(height: 0.08.sh), // Responsive height
            SizedBox(
              width: 0.6.sw,
              child: Image.asset(
                'assets/images/blukers_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 0.015.sh), // Responsive height
            Text(
              "Please Choose Your User Type",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: ThemeColors.black2ThemeColor,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp, // Responsive font size
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "This will help us tailor your experience to suit your need",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: ThemeColors.black2ThemeColor,
                fontWeight: FontWeight.w600,
                fontSize: 9.sp, // Responsive font size
              ),
            ),
            SizedBox(height: 0.08.sh), // Responsive height
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isWorkerSelected = true;
                      isCompanySelected = false;
                    });
                  },
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: isWorkerSelected
                          ? const BorderSide(
                        color: ThemeColors.blukersBlueThemeColor,
                        width: 2.0,
                      )
                          : const BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    child: Container(
                      color: isWorkerSelected
                          ? ThemeColors.blukersBlueThemeColor.withOpacity(0.10)
                          : Colors.transparent,
                      width: 0.45.sw,
                      height: 0.19.sh,
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          // checkbox
                          Positioned(
                            top: 0,
                            right: 0,
                            child: isWorkerSelected
                                ? Icon(
                              Icons.check_box_sharp,
                              color: ThemeColors.blukersBlueThemeColor,
                              size: 30.sp,
                            )
                                : Icon(
                              Icons.check_box_outline_blank,
                              color: ThemeColors.blukersBlueThemeColor,
                              size: 30.sp,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            clipBehavior: Clip.none,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                Image.asset(
                                  'assets/images/worker_insp.png',
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  "I am a\nworker",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ThemeColors.black2ThemeColor,
                                    fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 14.sp
                                        : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Looking for jobs",
                                  style: TextStyle(
                                    color: ThemeColors.black1ThemeColor,
                                    fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 9.sp
                                        : 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0.02.sw), // Responsive width
                InkWell(
                  onTap: () {
                    setState(() {
                      isWorkerSelected = false;
                      isCompanySelected = true;
                    });
                  },
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: isCompanySelected
                          ? const BorderSide(
                        color: ThemeColors.blukersBlueThemeColor,
                        width: 2.0,
                      )
                          : const BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    child: Container(
                      color: isCompanySelected
                          ? ThemeColors.blukersBlueThemeColor.withOpacity(0.10)
                          : Colors.transparent,
                      width: 0.45.sw,
                      height: 0.19.sh,
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          // checkbox
                          Positioned(
                            top: 0,
                            right: 0,
                            child: isCompanySelected
                                ? Icon(
                              Icons.check_box_sharp,
                              color: ThemeColors.blukersBlueThemeColor,
                              size: 30.sp,
                            )
                                : Icon(
                              Icons.check_box_outline_blank,
                              color: ThemeColors.blukersBlueThemeColor,
                              size: 30.sp,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            clipBehavior: Clip.none,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                Image.asset(
                                  'assets/images/company_insp.png',
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  "I am a\ncompany",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ThemeColors.black2ThemeColor,
                                    fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 14.sp
                                        : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Looking for workers",
                                  style: TextStyle(
                                    color: ThemeColors.black1ThemeColor,
                                    fontSize:
                                    MediaQuery.of(context).size.width < 600
                                        ? 9.sp
                                        : 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.07.sh), // Responsive height
            ElevatedButton(
              onPressed: () {
                if (isWorkerSelected) {
                  context.go('/jobs');
                } else if (isCompanySelected) {
                  context.go('/workers');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.blukersOrangeThemeColor,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.31,
                  vertical: 0.02.sh, // Responsive height
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Continue",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp, // Responsive font size
                    ),
                  ),
                  SizedBox(width: 0.05.sw), // Responsive width
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAuthButton(BuildContext context, onTap, text) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: const TextStyle(
                color: ThemeColors.blukersBlueThemeColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
