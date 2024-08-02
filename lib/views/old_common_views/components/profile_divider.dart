import 'package:flutter/material.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2, // thickness of the line
      indent: 10, // empty space to the leading edge of divider.
      endIndent: 10, // empty space to the trailing edge of the divider.
      color: Colors.grey.shade300, // The color to use when painting the line.
      // color: ThemeColors.black3ThemeColor,
      height: 1, // The divider's height extent.
    );
  }
}
