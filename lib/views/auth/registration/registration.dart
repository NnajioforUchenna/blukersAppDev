import 'package:blukers/views/auth/registration/registration_component/page_slider.dart';
import 'package:flutter/material.dart';

import 'registration_component/sign_up_timeline.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SignUpTimeline(),
          const Expanded(
            child: PageSlider(),
          ),
        ],
      ),
    );
  }
}
