import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/worker/worker_page_template/Components/sign_in_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../common_vieiws/desktop_nav_bar.dart';

class WorkerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WorkerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                )
              ],
            ),
          ),
          AppBar(
            title: const SignInRow(),
            iconTheme:
                const IconThemeData(color: ThemeColors.primaryThemeColor),
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              up.appUser == null
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: ProfileNavBar(),
                    )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 25); // Adjust height as needed
}
