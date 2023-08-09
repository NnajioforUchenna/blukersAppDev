import 'package:bulkers/services/responsive.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'list_industries.dart';

class DisplayIndustries extends StatelessWidget {
  const DisplayIndustries({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            const Icon(
              UniconsLine.hard_hat,
              color: ThemeColors.secondaryThemeColor,
              size: 60,
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.005,
            // ),

            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Text(
                "Select an Industry",
                textAlign: TextAlign.center,
                style: ThemeTextStyles.headerThemeTextStyle,
              ),
            ),
            // Top Space
            const SizedBox(height: 10),
            // Industries List View
            SizedBox(
              width: (Responsive.isDesktop(context))
                  ? MediaQuery.of(context).size.width * 0.6
                  : MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    style: BorderStyle.solid,
                    // width: 2.0,
                  ),
                  // color: Color(0xFFF05A22),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const ListIndustries(),
              ),
            ),
            // Bottom Space
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
