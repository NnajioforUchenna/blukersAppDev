import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'explanation_card.dart';

class MyJobTimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;
  final String briefDescription;

  const MyJobTimeLine(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.title,
      required this.briefDescription});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast
              ? ThemeColors.primaryThemeColor
              : ThemeColors.primaryThemeColor.withOpacity(0.3),
          thickness: 2,
        ),
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isPast
              ? ThemeColors.primaryThemeColor
              : ThemeColors.primaryThemeColor.withOpacity(0.3),
          iconStyle: IconStyle(
            color: isPast
                ? Colors.white
                : ThemeColors.primaryThemeColor.withOpacity(0.3),
            iconData: Icons.check,
          ),
          padding: EdgeInsets.all(8),
        ),
        endChild: ExplanationCard(
          title: title,
          briefDescription: briefDescription,
          isPast: isPast,
        ),
      ),
    );
  }
}
