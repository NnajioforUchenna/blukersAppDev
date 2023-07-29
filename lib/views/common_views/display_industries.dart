import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'list_industries.dart';

import '../../../utils/styles/index.dart';

class DisplayIndustries extends StatelessWidget {
  const DisplayIndustries({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Select an Industry",
              textAlign: TextAlign.center,
              style: ThemeTextStyles.headerThemeTextStyle,
            ),
          ),
          // Top Space
          const SizedBox(height: 10),
          // Industries List View
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
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
    );
  }
}
