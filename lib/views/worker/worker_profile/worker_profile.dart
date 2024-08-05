import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/worker/worker_profile/worker_profile_desktop.dart';
import 'package:blukers/views/worker/worker_profile/worker_profile_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../auth/common_widget/login_or_register.dart';

class WorkerProfile extends StatefulWidget {
  const WorkerProfile({super.key});

  @override
  State<WorkerProfile> createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);

    return up.appUser == null
        ? const LoginOrRegister()
        : const Responsive(
            mobile: WorkerProfileMobile(),
            desktop: WorkerProfileDesktop(),
          );
  }
}
