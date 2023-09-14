import 'package:flutter/material.dart';

import '../../services/responsive.dart';
import 'registration_process_component/page_slider.dart';
import 'registration_process_component/sign_up_timeline.dart';

class RegistrationProcess extends StatelessWidget {
  const RegistrationProcess({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width,
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(
              height: 50,
            ),
            SignUpTimeline(),
            // const CompanyLogo(),
            const SizedBox(height: 20),
            const PageSlider()
          ]))
        ],
      ),
    );
  }
}
