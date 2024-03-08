import 'package:flutter/material.dart';
import '../../utils/styles/index.dart';

class IconText404 extends StatelessWidget {
  const IconText404({
    super.key,
    required this.icon,
    required this.text,
    this.color = ThemeColors.grey1ThemeColor,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double myWidth = width * 0.90;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 50),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                color: ThemeColors.grey1ThemeColor,
                fontSize: 20,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
