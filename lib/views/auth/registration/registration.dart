import 'package:blukers/views/auth/registration/registration_component/page_slider.dart';
import 'package:flutter/material.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SignUpTimeline(),
          Expanded(
            child: PageSlider(),
          ),
        ],
      ),
    );
  }
}
