import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../auth/common_widget/auth_input.dart';
import '../timeline_navigation_button.dart';
import '../your_resume.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);

    CreateWorkerProfileProvider cwpp =
        Provider.of<CreateWorkerProfileProvider>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const YourResume(),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "LinkedIn URL",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AuthInput(
                  child: TextFormField(
                    controller: cwpp.linkedInUrlController,
                    textInputAction: TextInputAction.done,
                    validator: (value) => value!.isEmpty
                        ? AppLocalizations.of(context)!.required
                        : null,
                    decoration: InputDecoration(
                      //  hintText: "LinkedIn URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: ThemeColors.black1ThemeColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: ThemeColors.black1ThemeColor),
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
                        onPress: () => cwpp.workerProfileBackPage(),
                        navDirection: "back",
                      ),
                      TimelineNavigationButton(
                        isSelected: true,
                        onPress: () {
                          // Handle "submit" or "next" logic here
                          FocusScope.of(context).unfocus();
                          up.setJobTimelineStep(3);
                          cwpp.setResume(cwpp.linkedInUrlController.text);
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
