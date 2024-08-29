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

  final bool isCurrent; // Add a boolean to indicate the current step

  const ExplanationCard({
    super.key,
    required this.title,
    required this.briefDescription,
    required this.isPast,
    required this.index,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32, right: 25),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: isCurrent ? Colors.white : (isPast ? ThemeColors.lightGreenColor : Colors.white), // Set background color
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCurrent ? ThemeColors.blukersBlueThemeColor : (isPast ? ThemeColors.greenColor : Colors.transparent),
          width: isCurrent ? 2 : 1, // Border width for current step
        ),
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
            backgroundColor: isCurrent ? ThemeColors.secondaryThemeColor : (isPast ? ThemeColors.greenColor : ThemeColors.secondaryThemeColor),
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
                          color: isCurrent ? ThemeColors.darkBlueColor : (isPast ? ThemeColors.darkBlueColor : ThemeColors.darkBlueColor.withOpacity(0.3)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (isPast && !isCurrent)
                      const Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.greenColor,
                        ),
                      ),
                    if (isCurrent)
                      const Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange, // Use the same color as the image for the "Start" text
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
