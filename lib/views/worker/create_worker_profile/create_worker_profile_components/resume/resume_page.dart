import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../../providers/worker_provider.dart';
import '../../../../auth/common_widget/auth_input.dart';
import '../timeline_navigation_button.dart';
import '../your_resume.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final linkedInUrlController = TextEditingController();
    UserProvider up = Provider.of<UserProvider>(context);
    WorkersProvider wp = Provider.of<WorkersProvider>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const YourResume(),
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
                      onPress: () => wp.workerProfileBackPage(),
                      navDirection: "back",
                    ),
                    TimelineNavigationButton(
                      isSelected: true,
                      onPress: () {
                        // Handle "submit" or "next" logic here
                        up.setJobTimelineStep(2);
                        wp.setResume(linkedInUrlController.text);
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
    );
  }
}
