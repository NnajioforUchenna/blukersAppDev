import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/worker/worker_page_template/Components/sign_in_row.dart';
import 'package:flutter/material.dart';

class WorkerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WorkerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        title: const SignInRow(),
        iconTheme: const IconThemeData(color: ThemeColors.primaryThemeColor),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 25); // Adjust height as needed
}
