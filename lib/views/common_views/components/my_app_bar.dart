import 'package:flutter/material.dart';
import 'package:bulkers/utils/styles/index.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading = true;
  // final Widget? leading;
  final List<Widget>? actions;

  MyAppBar({
    required this.title,
    showLeading,
    // this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(
              context); // This line pops the current route and goes back
        },
      ),
      actions: actions,
      //
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(),
      backgroundColor: Colors.white,
      elevation: 2,
      shape: const Border(
        bottom: BorderSide(width: 2, color: Colors.black12),
      ),
      iconTheme: const IconThemeData(
        color: ThemeColors.primaryThemeColor,
      ),
      centerTitle: true,
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: ThemeTextStyles.appBarThemeTextStyle,
            ),
          ],
        ),
      ),
      //
    );
  }

  @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  Size get preferredSize => const Size.fromHeight(100);
}
