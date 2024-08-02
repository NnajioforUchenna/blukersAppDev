import 'package:blukers/views/auth/registration/registration_component/select_jobs_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../services/make_responsive_web.dart';
import 'app_user_information.dart';
import 'login_information.dart';
import 'registration_congratulation_page.dart';

class PageSlider extends StatefulWidget {
  const PageSlider({super.key});

  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: PageView(
          controller: up.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            MakeResponsiveWeb(
              image: AssetImage('assets/images/createAccount.png'),
              child: LoginInformation(),
            ),
            MakeResponsiveWeb(
              image: AssetImage('assets/images/basicInfo.png'),
              child: AppUserInformation(),
            ),
            MakeResponsiveWeb(
              image: AssetImage('assets/images/contactInfo.png'),
              child: SelectPreference(),
            ),
            RegistrationCongratulationPage(),
          ],
        ),
      ),
    );
  }
}
