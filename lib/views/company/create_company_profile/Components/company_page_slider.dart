import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/company_provider.dart';
import '../../../../services/make_responsive_web.dart';
import 'company_characteristics_page.dart';
import 'company_congratulation_page.dart';
import 'company_logo_page.dart';
import 'contact_details_page.dart';
import 'general_information_page.dart';
import 'social_media_page.dart';

class CompanyPageSlider extends StatefulWidget {
  const CompanyPageSlider({super.key});

  @override
  State<CompanyPageSlider> createState() => _CompanyPageSliderState();
}

class _CompanyPageSliderState extends State<CompanyPageSlider> {
  @override
  Widget build(BuildContext context) {
    // This provider might need to be adjusted for the company's timeline
    CompanyProvider cp = Provider.of<CompanyProvider>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: PageView(
          controller: cp.createCompanyProfilePageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            MakeResponsiveWeb(
                image: AssetImage('assets/images/generalInformationPage.png'),
                child: GeneralInformationPage()),
            MakeResponsiveWeb(
                image: AssetImage('assets/images/companyLogoPage.png'),
                child: CompanyLogoPage()),
            MakeResponsiveWeb(
                image: AssetImage('assets/images/contactDetailsPage.png'),
                child: ContactDetailsPage()),
            MakeResponsiveWeb(
                image: AssetImage('assets/images/socialMediaPage.png'),
                child: SocialMediaPage()),
            MakeResponsiveWeb(
                image:
                    AssetImage('assets/images/companyCharacteristicsPage.png'),
                child: CompanyCharacteristicsPage()),
            MakeResponsiveWeb(
                image: AssetImage('assets/images/workerCongratulationPage.png'),
                child: CompanyCongratulationPage()),
          ],
        ),
      ),
    );
  }
}
