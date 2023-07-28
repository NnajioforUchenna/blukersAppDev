import 'package:flutter/material.dart';

class CompanyLogo extends StatelessWidget {
  const CompanyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          // 'assets/icons/ic_launcher.png',
          'assets/images/looking_for_you.png',
          width: 270,
          // height: 45,
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
