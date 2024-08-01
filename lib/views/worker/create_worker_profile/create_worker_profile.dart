import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../auth/common_widget/login_or_register.dart';
import 'create_worker_profile_components/worker_page_slider.dart';
import 'create_worker_profile_components/worker_timeline.dart';

class CreateWorkerProfile extends StatelessWidget {
  const CreateWorkerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.appUser == null
        ? const LoginOrRegister()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Column(
              children: [
                WorkerTimeLine(),
                const Expanded(
                  child: WorkerPageSlider(),
                ),
              ],
            ),
          );
  }
}
