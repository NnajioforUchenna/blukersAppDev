import 'package:flutter/material.dart';

import '../../../../utils/styles/index.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading = true;
  // final Widget? leading;
  final List<Widget>? actions;

  const MyAppBar({
    super.key,
    required this.title,
    showLeading,
    // this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // title: Text(title),


      actions: actions,
      //
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(),
      backgroundColor: Colors.white,
      elevation: 1,
      shape: const Border(
        bottom: BorderSide(width: 2, color: Color.fromARGB(15, 0, 0, 0)),
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
