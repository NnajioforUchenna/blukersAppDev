import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';

class LabelButton extends StatelessWidget {
  const LabelButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.titleColor = const Color(0xFF8A8A8E),
      this.subTitleColor = Colors.deepOrangeAccent,
      this.subTitle = ''});
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  final Color titleColor;
  final Color subTitleColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: Responsive.isMobile(context)
            ? const EdgeInsets.symmetric(vertical: 15)
            : EdgeInsets.zero,
        decoration: Responsive.isMobile(context)
            ? const BoxDecoration(
                border: Border(
                    top: BorderSide(color: ThemeColors.secondaryThemeColorDark),
                    bottom:
                        BorderSide(color: ThemeColors.secondaryThemeColorDark)),
              )
            : null,
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: Responsive.isMobile(context) ? 12.sp : 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              subTitle,
              style: TextStyle(
                color: subTitleColor,
                fontSize: Responsive.isMobile(context) ? 12.sp : 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
