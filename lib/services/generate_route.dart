import 'package:flutter/material.dart';

import '../views/common_views/landing_page/landing_page.dart';
import '../views/company/workers.dart';

MaterialPageRoute generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => LandingPage());
    case '/workers':
      return MaterialPageRoute(builder: (context) => const Workers());
    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
