import 'package:blukers/views/auth/registration/registration_component/select_jobs_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/make_responsive_web.dart';
import 'basic_information.dart';
import 'login_information.dart';
import 'registration_congratulation_page.dart';

class PageSlider extends StatefulWidget {
  const PageSlider({
    super.key,
  });

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
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    if (_currentPageIndex != up.registerCurrentPageIndex) {
      animateToNextPage();
      _currentPageIndex = up.registerCurrentPageIndex;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            MakeResponsiveWeb(
              image: AssetImage('assets/images/createAccount.png'),
              child: LoginInformation(),
            ),
            MakeResponsiveWeb(
              image: AssetImage('assets/images/basicInfo.png'),
              child: BasicInformation(),
            ),
            MakeResponsiveWeb(
              image: AssetImage('assets/images/contactInfo.png'),
              child: SelectJobsPreference(),
            ),
            RegistrationCongratulationPage(),
          ],
        ),
      ),
    );
  }
}
