import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/responsive.dart';

class LabelButton extends StatelessWidget {
  const LabelButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.subTitle = ''});
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF8A8A8E),
                fontSize: Responsive.isMobile(context) ? 16.sp : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              subTitle,
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: Responsive.isMobile(context) ? 16.sp : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
