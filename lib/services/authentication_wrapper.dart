import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../views/common_views/job_timeline.dart';
import '../views/company/workers.dart';
import '../views/worker/jobs.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    if (up.user != null) {
      return up.appUser != null && up.appUser?.registeredAs == 'company'
          ? const Workers() //CreateWorkerProfile //Workers() //Jobs()
          : const Jobs();
    } else {
      return JobTimeline();
    }
  }
}

// const DisplayJobs(
// title: 'Agricultural Technician',
// )
