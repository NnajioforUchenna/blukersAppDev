import 'package:flutter/material.dart';

import '../views/auth/sign_up_timeline.dart';
import '../views/common_views/landing_page/landing_page.dart';
import '../views/company/workers.dart';
import '../views/worker/jobs.dart';

MaterialPageRoute generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => SignUpTimeline());
    case '/workers':
      return MaterialPageRoute(builder: (context) => const Workers());
    case '/jobs':
      return MaterialPageRoute(builder: (context) => const Jobs());
    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
