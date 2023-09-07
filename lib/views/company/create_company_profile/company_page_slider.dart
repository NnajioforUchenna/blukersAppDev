import 'package:blukers/providers/company_provider.dart';
import 'package:blukers/services/make_responsive_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'company_characteristics_page.dart';
import 'company_congratulation_page.dart';
import 'company_logo_page.dart';
import 'contact_details_page.dart';
import 'general_information_page.dart';
import 'social_media_page.dart';

class CompanyPageSlider extends StatefulWidget {
  const CompanyPageSlider({Key? key}) : super(key: key);

  @override
  _CompanyPageSliderState createState() => _CompanyPageSliderState();
}

class _CompanyPageSliderState extends State<CompanyPageSlider> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentPageIndex = Provider.of<CompanyProvider>(context, listen: false)
        .companyProfileCurrentPageIndex; // Adjusted for the company's timeline
    _pageController = PageController(
      initialPage: _currentPageIndex,
    );
  }

  void animateToNextPage(index) {
    if (_currentPageIndex < 6) {
      // Adjusted for the 7 steps in CompanyPageSlider
      _pageController.animateToPage(
        index,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This provider might need to be adjusted for the company's timeline
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    if (_currentPageIndex != cp.companyProfileCurrentPageIndex) {
      animateToNextPage(cp.companyProfileCurrentPageIndex);
      _currentPageIndex = cp.companyProfileCurrentPageIndex;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MakeResponsiveWeb(
                image: const AssetImage(
                    'assets/images/generalInformationPage.png'),
                child: GeneralInformationPage()),
            MakeResponsiveWeb(
                image: const AssetImage('assets/images/companyLogoPage.png'),
                child: CompanyLogoPage()),
            const MakeResponsiveWeb(
                image: AssetImage('assets/images/contactDetailsPage.png'),
                child: ContactDetailsPage()),
            MakeResponsiveWeb(
                image: const AssetImage('assets/images/socialMediaPage.png'),
                child: SocialMediaPage()),
            MakeResponsiveWeb(
                image: const AssetImage(
                    'assets/images/companyCharacteristicsPage.png'),
                child: CompanyCharacteristicsPage()),
            const MakeResponsiveWeb(
                image: AssetImage('assets/images/workerCongratulationPage.png'),
                child: CompanyCongratulationPage()),
          ],
        ),
      ),
    );
  }
}
