import 'package:blukers/views/common_views/splash_screen/splash_screen_custom_shape.dart';
import 'package:flutter/material.dart';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          SplashScreenCustomShape(
            width: width > 370 ? 350 : width * 0.8,
            height: height > 650 ? 625 : height * 0.8,
            workerTitle: workerTitle,
            workerSubtitle: workerSubtitle,
            companyTitle: companyTitle,
            companySubtitle: companySubtitle,
          ),
          // Center(
          //   child:
          // ),
        ],
      ),
    );
  }
}
