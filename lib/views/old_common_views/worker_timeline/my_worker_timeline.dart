import '../../../utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../job_timeline/explanation_card.dart';

class MyWorkerTimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;
  final String briefDescription;
  final int index;

  const MyWorkerTimeLine(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.title,
      required this.briefDescription,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.2,
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
            // iconData: Icons.circle_rounded,
            iconData: Icons.arrow_right_alt_sharp,
          ),
          padding: const EdgeInsets.all(8),
        ),
        endChild: ExplanationCard(
          index:  index,
          title: title,
          briefDescription: briefDescription,
          isPast: isPast,
          isCurrent: false,
        ),
      ),
    );
  }
}
