import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../utils/styles/index.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.heading,
    required this.icon,
    this.menuIcon = UniconsLine.circle,
    required this.onClickSection,
    this.onClickEdit,
    this.showBasicInfo,
    this.showInfoInNewPage = false,
    this.showEditIcon = true,
  });
  final String heading;
  final IconData icon;
  final IconData menuIcon;
  final VoidCallback onClickSection;
  final VoidCallback? onClickEdit;
  final bool? showInfoInNewPage;
  final bool? showBasicInfo;
  final bool showEditIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      child: Row(
        children: [
          Icon(
            menuIcon,
            // color: Colors.grey[700],
            color: ThemeColors.black3ThemeColor,
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: onClickSection,
              child: Text(
                heading,
                // style: ThemeTextStyles.headingThemeTextStyle.apply(
                //   color: ThemeColors.black3ThemeColor,
                // ),
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  color: ThemeColors.black3ThemeColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (showEditIcon && showInfoInNewPage == true)
            GestureDetector(
              onTap: onClickEdit ?? onClickSection,
              child: Icon(
                icon,
                color: ThemeColors.grey1ThemeColor,
                size: 55,
              ),
            ),
          if (showEditIcon && showInfoInNewPage == false)
            GestureDetector(
              onTap: onClickEdit ?? onClickSection,
              child: Icon(
                icon,
                color: ThemeColors.secondaryThemeColor,
                size: 30,
              ),
            ),
          if (showBasicInfo != null)
            GestureDetector(
              onTap: onClickSection,
              child: Icon(
                showBasicInfo! ? UniconsLine.angle_up : UniconsLine.angle_down,
                // color: Colors.grey[700],
                color: showBasicInfo!
                    ? ThemeColors.primaryThemeColor
                    : ThemeColors.grey1ThemeColor,
                size: 60,
              ),
            ),
        ],
      ),
    );
  }
}
