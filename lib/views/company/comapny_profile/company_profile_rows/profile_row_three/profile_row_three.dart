import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';

class CompanyProfileRowThree extends StatelessWidget {
  const CompanyProfileRowThree({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 30.0),
      child: Text(
        up.appUser!.getDisplayName,
        style: GoogleFonts.montserrat(
          color: ThemeColors.blukersOrangeThemeColor,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
