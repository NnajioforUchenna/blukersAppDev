import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../services/responsive.dart';
import '../../../../../utils/styles/index.dart';
import 'select_industries_to_update.dart';

class UpdateIndustry extends StatefulWidget {
  const UpdateIndustry({super.key});

  @override
  State<UpdateIndustry> createState() => _UpdateIndustryState();
}

class _UpdateIndustryState extends State<UpdateIndustry> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(
   
        left: Responsive.isMobile(context) ? 25 : 40,
        right: Responsive.isMobile(context) ? 25 : 40,
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: Responsive.isMobile(context)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Text(
                  'Industries/Jobs',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: Responsive.isMobile(context) ? 20 : 29),
                ),
              ],
            ),
            const SizedBox(
              height: 56,
            ),
            SizedBox(
              height: height * 0.55,
              child: const SelectIndustriesToUpdate(),
            ),
             const SizedBox(
              height: 36,
            ),
            Flexible(
              child: Center(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      UserProvider up =
                          Provider.of<UserProvider>(context, listen: false);
                      up.updateIndustriesAndJobs();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                  
                      backgroundColor: ThemeColors.primaryThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Update Changes',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: Responsive.isMobile(context) ? 9.sp : 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
             const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
