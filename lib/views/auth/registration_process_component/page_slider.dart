import 'package:blukers/services/make_responsive_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';
import 'basic_information.dart';
import 'contact_information_page.dart';
import 'login_information.dart';
import 'registration_congratulation_page.dart';

class PageSlider extends StatefulWidget {
  const PageSlider({
    Key? key,
  }) : super(key: key);

  @override
  _PageSliderState createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentPageIndex = Provider.of<UserProvider>(context, listen: false)
        .registerCurrentPageIndex;
    _pageController = PageController(
      initialPage: _currentPageIndex,
    );
  }

  void animateToNextPage() {
    if (_currentPageIndex < 3) {
      _pageController.animateToPage(
        _currentPageIndex + 1,
        duration: const Duration(
            seconds: 1), // Set the animation duration to 5 seconds
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    if (_currentPageIndex != up.registerCurrentPageIndex) {
      // Add this line) {
      animateToNextPage();
      _currentPageIndex = up.registerCurrentPageIndex;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const MakeResponsiveWeb(
              image: AssetImage('assets/images/createAccount.png'),
              child: LoginInformation()),
          MakeResponsiveWeb(
              image: const AssetImage('assets/images/basicInfo.png'),
              child: BasicInformation()),
          const MakeResponsiveWeb(
              image: AssetImage('assets/images/contactInfo.png'),
              child: ContantInformationPage()),
          const RegistrationCongratulationPage(),
        ],
      ),
    );
  }
}
