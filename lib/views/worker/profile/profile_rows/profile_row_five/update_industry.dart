import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common_views/small_pop_button_widget.dart';
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
            width: double.infinity,
            margin: EdgeInsets.only(top: height * 0.05, bottom: height * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: height * 0.05,
                        bottom: height * 0.06,
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
                  SelectIndustriesToUpdate()
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
