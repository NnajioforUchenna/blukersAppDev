import 'package:flutter/material.dart';

import '../../../utils/styles/index.dart';
import '../components/custom_time_line_row.dart';
import 'explanation_card.dart';

class MyJobTimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;

  final bool isCurrent;
  
  final String briefDescription;
  final int index;

  const MyJobTimeLine(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.isCurrent,
      required this.title,
      required this.briefDescription,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: CustomTimeLineTile(
        isFirst: isFirst,
        isLast: isLast,
         isPast: isPast,
        beforeLineStyle: LineStyle(
          color: isPast
              ? ThemeColors.secondaryThemeColor
              : ThemeColors.secondaryThemeColor.withOpacity(0.3),
          thickness: 2,
        ),
        endChild: ExplanationCard(
          isCurrent: isCurrent,
          index: index,
          title: title,
          briefDescription: briefDescription,
          isPast: isPast,
        ),
      ),
    );
  }
}
