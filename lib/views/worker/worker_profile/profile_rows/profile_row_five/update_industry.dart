import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../services/responsive.dart';
import '../../../../../utils/styles/index.dart';
import '../../../../old_common_views/small_pop_button_widget.dart';
import 'select_industries_to_update.dart';

class UpdateIndustry extends StatefulWidget {
  const UpdateIndustry({super.key});

  @override
  State<UpdateIndustry> createState() => _UpdateIndustryState();
}

class _UpdateIndustryState extends State<UpdateIndustry> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      insetPadding:
          const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 80),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: height * 0.05,
                        bottom: height * 0.02,
                        left: width * 0.2,
                        right: width * 0.2),
                    child: Text(
                      'Select your Industries and Jobs',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          color: ThemeColors.secondaryThemeColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.55,
                    child: const SelectIndustriesToUpdate(),
                  ),
                  Flexible(
                    child: Center(
                      child: Container(
                        height: height * 0.03,
                        width: width * 0.30,
                        margin:
                            EdgeInsets.only(top: height * 0.03, bottom: 30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            UserProvider up = Provider.of<UserProvider>(context,
                                listen: false);
                            up.updateIndustriesAndJobs();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: ThemeColors.secondaryThemeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            'Update',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize:
                                  Responsive.isMobile(context) ? 9.sp : 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 10, // Adjust as needed
            left: 10, // Adjust as needed
            child: SmallPopButtonWidget(),
          ),
        ],
      ),
    );
  }
}
