import 'package:flutter/material.dart';

import '../../../utils/styles/theme_colors.dart';

class ExplanationCard extends StatelessWidget {
  final String title;
  final String briefDescription;
  final bool isPast;
  const ExplanationCard(
      {super.key,
      required this.title,
      required this.briefDescription,
      required this.isPast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isPast
                    ? ThemeColors.secondaryThemeColor
                    : ThemeColors.secondaryThemeColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              briefDescription,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
