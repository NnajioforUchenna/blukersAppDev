import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection(
      {super.key,
      required this.heading,
      required this.icon,
      required this.onClickSection,
      this.onClickEdit});
  final String heading;
  final IconData icon;
  final VoidCallback onClickSection;
  final VoidCallback? onClickEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onClickSection,
              child: Text(
                heading,
                style: ThemeTextStyles.headingThemeTextStyle
                    .apply(color: Colors.black),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClickSection,
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey[700],
              size: 30,
            ),
          ),
          GestureDetector(
            onTap: onClickEdit ?? onClickSection,
            child: Icon(
              icon,
              color: Colors.grey[700],
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
