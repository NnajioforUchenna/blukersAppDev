import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/worker/worker_page_template/Components/sign_in_row.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WorkerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Center(
              child: Text(
                'Blukers Job Platform',
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
            title: const SignInRow(),
            iconTheme:
                const IconThemeData(color: ThemeColors.primaryThemeColor),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 25); // Adjust height as needed
}
