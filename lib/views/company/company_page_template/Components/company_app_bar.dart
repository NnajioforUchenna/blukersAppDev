import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/styles/theme_colors.dart';
import 'company_signIn_row.dart';

class CompanyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CompanyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // Background color for the row
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Blukers Talent Platform',
                style: GoogleFonts.montserrat(
                  color: ThemeColors.primaryThemeColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          AppBar(
            title: const CompanySignInRow(),
            iconTheme:
                const IconThemeData(color: ThemeColors.primaryThemeColor),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 40); // Adjust height as needed
}
