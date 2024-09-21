import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../models/worker.dart';
import '../../../../../services/blur_out.dart';
import '../../../../../services/responsive.dart';

class WorkerDetailBlockTwo extends StatelessWidget {
  final Worker worker;

  const WorkerDetailBlockTwo({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    bool isBlur = false; // You can change this value based on your requirements

    return Padding(
      padding:  EdgeInsets.only(top: Responsive.isMobile(context) ? 16 : 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
        children: [
          Text("Personal Information",
              style: GoogleFonts.montserrat(
                  fontSize:Responsive.isMobile(context)? 14: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 15),
          Row(
            children: [
            Icon(
                Icons.mail_outline_sharp,
                size: Responsive.isMobile(context)? 13: 20,
                color: ThemeColors.secondaryThemeColorDark,
              ),
              const SizedBox(width: 8),
              Text(
                "Email: ",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.5),
                    fontSize: Responsive.isMobile(context) ? 12 : 16),
              ),
              Flexible(
                child: BlurOut(
                  isBlur: isBlur,
                  child: Text(
                    worker.emails.isNotEmpty
                        ? worker.emails.first
                        : 'Email Not Provided',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: Responsive.isMobile(context) ? 12 : 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.isMobile(context) ?8 : 15),
          Row(
            children: [
               Icon(
                Icons.phone_outlined,
                              size: Responsive.isMobile(context)? 13: 20,
                color: ThemeColors.secondaryThemeColorDark,
              ),
              const SizedBox(width: 8),
              Text(
                "Phone Number: ",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.5),
                    fontSize: Responsive.isMobile(context) ? 12 : 16),
              ),
              Flexible(
                child: BlurOut(
                  isBlur: isBlur,
                  child: Text(
                    worker.phoneNumber.isEmpty ? "--": worker.phoneNumber,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: Responsive.isMobile(context) ? 12 : 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
           SizedBox(height:Responsive.isMobile(context)? 16: 30),
          const Divider(
             color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
        ],
      ),
    );
  }
}
