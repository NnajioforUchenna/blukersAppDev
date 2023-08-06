import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../auth/common_widget/login_or_register.dart';
import '../common_views/page_template/page_template.dart';

class WorkerProfile extends StatelessWidget {
  const WorkerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return PageTemplate(
        child: up.appUser == null
            ? const LoginOrRegister()
            : const Column(
                children: [
                  Row(children: [
                    // Spacer(),
                    Text("Worker"),
                    // CreateYourProfile(),
                  ]),
                ],
              ));
  }
}
