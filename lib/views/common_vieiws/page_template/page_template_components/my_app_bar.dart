import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/common_vieiws/page_template/page_template_components/sign_in_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_settings_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);
    return AppBar(
      title: const SignInRow(),
      iconTheme: const IconThemeData(color: ThemeColors.primaryThemeColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
