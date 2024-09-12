import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/styles/index.dart';

class LandingPageDesktop extends StatefulWidget {
  const LandingPageDesktop({super.key});

  @override
  State<LandingPageDesktop> createState() => _LandingPageDesktopState();
}

class _LandingPageDesktopState extends State<LandingPageDesktop> {
  bool isWorkerSelected = false;
  bool isCompanySelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 0.05.sh), // Responsive height
          SizedBox(
            width: 0.3.sw,
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
              fontSize: 8.sp, // Responsive font size
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "This will help us tailor your experience to suit your need",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: ThemeColors.black2ThemeColor,
              fontWeight: FontWeight.w600,
              fontSize: 3.sp, // Responsive font size
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
                            width: 2.0)
                        : const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  child: Container(
                    color: isWorkerSelected
                        ? ThemeColors.blukersBlueThemeColor.withOpacity(0.10)
                        : Colors.transparent,
                    width: 0.25.sw,
                    height: 0.30.sh,
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        //checkbox
                        Positioned(
                          top: 0,
                          right: 0,
                          child: isWorkerSelected
                              ? Icon(
                                  Icons.check_box_sharp,
                                  color: ThemeColors.blukersBlueThemeColor,
                                  size: 10.sp,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  color: ThemeColors.blukersBlueThemeColor,
                                  size: 10.sp,
                                ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 0.02.sh,
                              ),
                              Image.asset(
                                'assets/images/worker_insp_desc.png',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                textAlign: TextAlign.left,
                                "I am a worker",
                                style: TextStyle(
                                  color: ThemeColors.black2ThemeColor,
                                  fontSize: 5.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Looking for jobs",
                                style: TextStyle(
                                  color: ThemeColors.black1ThemeColor,
                                  fontSize: 3.sp,
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
                            width: 2.0)
                        : const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  child: Container(
                    color: isCompanySelected
                        ? ThemeColors.blukersBlueThemeColor.withOpacity(0.10)
                        : Colors.transparent,
                    width: 0.25.sw,
                    height: 0.30.sh,
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        //checkbox
                        Positioned(
                          top: 0,
                          right: 0,
                          child: isCompanySelected
                              ? Icon(
                                  Icons.check_box_sharp,
                                  color: ThemeColors.blukersBlueThemeColor,
                                  size: 10.sp,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  color: ThemeColors.blukersBlueThemeColor,
                                  size: 10.sp,
                                ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 0.02.sh,
                              ),
                              Image.asset(
                                'assets/images/company_insp_desc.png',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                textAlign: TextAlign.left,
                                "I am a company",
                                style: TextStyle(
                                  color: ThemeColors.black2ThemeColor,
                                  fontSize: 5.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Looking for workers",
                                style: TextStyle(
                                  color: ThemeColors.black1ThemeColor,
                                  fontSize: 3.sp,
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
                horizontal: 0.05.sw, // Responsive width
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
                      fontSize: 5.sp // Responsive font size
                      ),
                ),
                SizedBox(width: 0.01.sw), // Responsive width
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ), // Responsive button
        ],
      ),
    ));
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
