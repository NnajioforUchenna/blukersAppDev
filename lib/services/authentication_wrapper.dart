import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../views/common_views/landing_page_components/landing_page.dart';
import '../views/worker/create_worker_profile_component/create_worker_profile.dart';
import '../views/worker/jobs_componets/display_jobs.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    if (up.user != null) {
      return up.appUser != null && up.appUser?.registeredAs == 'company'
          ? const DisplayJobs(
              title: 'Farmer',
            ) //CreateWorkerProfile //Workers() //Jobs()
          : CreateWorkerProfile();
    } else {
      return LandingPage();
    }
  }
}
