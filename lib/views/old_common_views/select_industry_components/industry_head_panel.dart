import 'package:flutter/material.dart';

import '../../../models/industry.dart';
import '../../../services/on_hover.dart';
import '../../../services/responsive.dart';
import '../../../utils/localization/localized_industries.dart';
import '../../../utils/styles/index.dart';

class IndustryHeadPanel extends StatelessWidget {
  final Industry industry;
  const IndustryHeadPanel({super.key, required this.industry});

  @override
  Widget build(BuildContext context) {
    return OnHover(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: Responsive.isDesktop(context) ? 70 : 50,
              height: Responsive.isDesktop(context) ? 70 : 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit
                      .cover, // This ensures the image covers the circular area
                  image: AssetImage(industry.imageUrl!),
                ),
              ),
            ),
          ),
          SizedBox(width: Responsive.isDesktop(context) ? 25 : 10),
          Expanded(
              child: Text(
            LocalizedIndustries.get(context, industry.industryId),
            style: TextStyle(
              fontSize: Responsive.isDesktop(context) ? 30 : 20,
              fontWeight: FontWeight.w500,
              color: ThemeColors.grey1ThemeColor,
            ),
          )),
        ],
      ),
    );
  }
}
