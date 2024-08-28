import 'package:flutter/material.dart';

import '../../../utils/styles/index.dart';
import '../components/custom_time_line_row.dart';
import 'explanation_card.dart';

class MyJobTimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;
  final String briefDescription;
  final int index;

  const MyJobTimeLine(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.title,
      required this.briefDescription,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: CustomTimeLineTile(
        isCompleted: index == 0,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast
              ? ThemeColors.secondaryThemeColor
              : ThemeColors.secondaryThemeColor.withOpacity(0.3),
          thickness: 2,
        ),
        // indicatorStyle: IndicatorStyle(

        //   width: 40,
        //   color: isPast
        //       ? ThemeColors.blukersBlueThemeColor
        //       : ThemeColors.blukersBlueThemeColor.withOpacity(0.3),
        //   iconStyle: IconStyle(
        //     color: isPast
        //         ? Colors.white
        //         : ThemeColors.blukersBlueThemeColor.withOpacity(0.3),
        //     // iconData: Icons.circle_rounded,
        //     iconData: Icons.arrow_right_alt_sharp,
        //   ),
        //   padding: const EdgeInsets.all(8),
        // ),
        endChild: ExplanationCard(
          isCompleted: index == 0,
          index: index,
          title: title,
          briefDescription: briefDescription,
          isPast: isPast,
        ),
      ),
    );
  }
}
