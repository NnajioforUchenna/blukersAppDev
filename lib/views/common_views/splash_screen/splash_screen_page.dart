import 'package:bulkers/views/common_views/splash_screen/splash_screen_custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreenPage extends StatelessWidget {
  final String workerTitle;
  final String workerSubtitle;
  final String companyTitle;
  final String companySubtitle;

  const SplashScreenPage({
    Key? key,
    required this.workerTitle,
    required this.workerSubtitle,
    required this.companyTitle,
    required this.companySubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: SplashScreenCustomShape(
              workerTitle: workerTitle,
              workerSubtitle: workerSubtitle,
              companyTitle: companyTitle,
              companySubtitle: companySubtitle,
            ),
          ),
          SizedBox(height: 30.h),
          // Add skip button
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/landing');
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
