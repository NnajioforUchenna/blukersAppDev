import 'package:blukers/services/responsive.dart';
import 'package:flutter/material.dart';

import 'landing_page_desktop.dart';
import 'landing_page_mobile.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(mobile:LandingPageMobile() , desktop: LandingPageDesktop());
  }
}
