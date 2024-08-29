import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/styles/index.dart';
import '../../../utils/styles/theme_colors.dart';

class ExplanationCard extends StatelessWidget {
  final String title;
  final String briefDescription;
  final bool isPast;
  final int index;
  final bool isCompleted;
  const ExplanationCard(
      {super.key,
      required this.title,
      required this.briefDescription,
      required this.isPast,
      this.isCompleted = false,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32, right: 25),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: isCompleted ? ThemeColors.lightGreenColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: isCompleted
            ? Border.all(
                color: ThemeColors.greenColor,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: isCompleted
                ? ThemeColors.greenColor
                : ThemeColors.secondaryThemeColor,
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 16.sp : 18,
                          fontWeight: FontWeight.bold,
                          color: isPast
                              ? ThemeColors.darkBlueColor
                              : ThemeColors.darkBlueColor.withOpacity(0.3),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (isCompleted)
                      const Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.greenColor,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  briefDescription,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
