import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_settings_provider.dart';
import '../../../../utils/styles/theme_colors.dart';
import 'company_signIn_row.dart';

class CompanyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CompanyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return AppBar(
      title: const CompanySignInRow(),
      iconTheme: const IconThemeData(color: ThemeColors.primaryThemeColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
