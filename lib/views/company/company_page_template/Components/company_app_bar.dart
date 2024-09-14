import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../utils/styles/theme_colors.dart';
import '../../../common_vieiws/desktop_nav_bar.dart';
import 'company_signIn_row.dart';

class CompanyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CompanyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return SafeArea(
        child: AppBar(
      title: const CompanySignInRow(),
      iconTheme: const IconThemeData(color: ThemeColors.primaryThemeColor),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        up.appUser == null
            ? const SizedBox.shrink()
            : const Padding(
                padding: EdgeInsets.only(right: 24),
                child: ProfileNavBar(),
              )
      ],
    ));
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 40); // Adjust height as needed
}
