
import 'package:blukers/providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/styles/theme_colors.dart';

class JobPopButtonWidget extends StatelessWidget {
  const JobPopButtonWidget({super.key, });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<JobPostsProvider>().clearSearchParameters();
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
