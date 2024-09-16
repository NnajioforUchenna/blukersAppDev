import 'package:blukers/views/auth/registration/registration_component/select_jobs_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider_parts/user_provider.dart';
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
        child: PageView(
          controller: up.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ResponsiveRegistration(
              image: up.userRole == "worker"
                  ? "assets/images/email_password.png"
                  : "assets/images/email_password_worker.png",
              child: const LoginInformation(),
            ),
            ResponsiveRegistration(
              image: up.userRole == "worker"
                  ? "assets/images/user_info.png"
                  : "assets/images/worker_prefs_info.png",
              child: const AppUserInformation(),
            ),
            ResponsiveRegistration(
              image: up.userRole == "worker"
                  ? "assets/images/job_prefs.png"
                  : "assets/images/work_prefs.png",
              child: const SelectPreference(),
            ),
            const RegistrationCongratulationPage(),
          ],
        ),
      ),
    );
  }
}

class ResponsiveRegistration extends StatelessWidget {
  const ResponsiveRegistration(
      {super.key, required this.child, required this.image});
  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Desktop layout
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .85,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 58,
                    ),
                    Expanded(
                      child: child,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          // Mobile layout
          return child;
        }
      },
    );
  }
}
