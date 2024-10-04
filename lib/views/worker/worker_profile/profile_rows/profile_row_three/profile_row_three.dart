import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';

class ProfileRowThree extends StatelessWidget {
  const ProfileRowThree({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 18.0, bottom: Responsive.isMobile(context) ? 40 :  24.0),
      child: Text(
        up.appUser!.getDisplayName,
        style: GoogleFonts.montserrat(
          color: ThemeColors.blukersOrangeThemeColor,
          fontSize: Responsive.isMobile(context)? 14 :  17,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
