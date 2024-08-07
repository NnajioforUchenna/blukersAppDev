import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/styles/theme_colors.dart';

class WorkerPopButtonWidget extends StatelessWidget {
  const WorkerPopButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
        } else {
          GoRouter.of(context).go('/workers');
        }
      },
      child: Material(
        elevation: 4.0, // Set the elevation here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              16.0), // Half of the width/height to make it a perfect circle
        ),
        child: Container(
          width: 32, // Adjust as needed
          height: 32, // Adjust as needed
          decoration: const BoxDecoration(
            color: ThemeColors.secondaryThemeColor, // Adjust as needed
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'X',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700, // Make it bold
                fontSize: 16, // Adjust the size
                color: Colors.white, // Set the color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
