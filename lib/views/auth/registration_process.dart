import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';

import '../../services/responsive.dart';
import 'common_widget/company_logo.dart';
import 'registration_process_component/page_slider.dart';
import 'registration_process_component/sign_up_timeline.dart';

class RegistrationProcess extends StatelessWidget {
  RegistrationProcess({super.key});
  // PageSlider controller
  final PageController _pageController = PageController(initialPage: 0);
  // Function to go to the next page in PageSlider

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   // title: const Center(
      //   //   child: Text(
      //   //     'Registration Process',
      //   //     style: ThemeTextStyles.headerThemeTextStyle,
      //   //   ),
      //   // ),
      // ),
      body: Center(
        child: SizedBox(
          height: height,
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width,
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                SignUpTimeline(),
                // const CompanyLogo(),
                const SizedBox(height: 20),
                const PageSlider()
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
