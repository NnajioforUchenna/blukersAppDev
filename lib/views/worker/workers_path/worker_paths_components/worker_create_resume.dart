import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:blukers/views/auth/common_widget/auth_input.dart';
import 'package:blukers/views/worker/create_worker_profile/create_worker_profile_components/timeline_navigation_button.dart';
import 'package:blukers/views/worker/workers_path/worker_paths_components/resume_components/your_resume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/user_provider_parts/user_provider.dart';

class WorkerCreateResume extends StatelessWidget {
  const WorkerCreateResume({super.key});

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final linkedInUrlController = TextEditingController();
    UserProvider up = Provider.of<UserProvider>(context);
    // WorkersProvider wp = Provider.of<WorkersProvider>(context);
    CreateWorkerProfileProvider wp =
        Provider.of<CreateWorkerProfileProvider>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Upload Resume",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                const SizedBox(height: 20),
                const Resume(),
                const SizedBox(height: 20),
                AuthInput(
                  child: TextFormField(
                    controller: linkedInUrlController,
                    textInputAction: TextInputAction.done,
                    validator: (value) => value!.isEmpty
                        ? AppLocalizations.of(context)!.required
                        : null,
                    decoration: InputDecoration(
                      hintText: "LinkedIn URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimelineNavigationButton(
                          isSelected: true,
                          onPress: () {
                            context.go('/pathToJob');
                          }),
                      TimelineNavigationButton(
                        isSelected: true,
                        onPress: () {
                          if (up.isResumeUploaded) {
                            print("next");
                            up.setJobTimelineStep(3);
                            wp.setResume(linkedInUrlController.text);
                            context.go('/pathToJob');
                          } else {
                            print("Resume not uploaded");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Please upload your resume before proceeding."),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
