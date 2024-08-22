import 'package:blukers/views/worker/worker_profile/worker_profile_mobile.dart';
import 'package:flutter/material.dart';

class WorkerProfileDesktop extends StatelessWidget {
  const WorkerProfileDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (constraints.maxWidth >= 600)
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.asset(
                      '../../../assets/images/desktopprofilepic.png',
                      width: 900,
                      height: 1000,
                    ),
                  ),
                ),
              // Profile content on the right
              const Expanded(child: WorkerProfileMobile()),
            ],
          ),
        );
      },
    );
  }
}
