import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../utils/styles/theme_colors.dart';
import '../../auth/common_widget/auth_input.dart';
import 'your_resume.dart';

import 'package:blukers/views/common_views/components/timelines/timeline_navigation_button.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final linkedInUrlController = TextEditingController();
    UserProvider up = Provider.of<UserProvider>(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Text(
              //   AppLocalizations.of(context)!.uploadYourResume,
              //   textAlign: TextAlign.center,
              //   style: const TextStyle(
              //     color: Colors.deepOrangeAccent,
              //     fontSize: 25,
              //     fontWeight: FontWeight.w600,
              //     height: 1.25,
              //   ),
              // ),
              const SizedBox(height: 20),
              YourResume(),
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
                    // ElevatedButton(
                    //   onPressed: () {
                    //     wp.workerProfileBackPage();
                    //   },
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all<Color>(
                    //         ThemeColors.secondaryThemeColor),
                    //   ),
                    //   child: Text(
                    //     AppLocalizations.of(context)!.previous,
                    //     style: TextStyle(
                    //       fontFamily: "Montserrat",
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // Handle "submit" or "next" logic here
                    //     up.setJobTimelineStep(2);
                    //     wp.setResume(linkedInUrlController.text);
                    //   },
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all<Color>(
                    //         ThemeColors.secondaryThemeColor),
                    //   ),
                    //   child: Text(
                    //     AppLocalizations.of(context)!.next,
                    //     style: TextStyle(
                    //       fontFamily: "Montserrat",
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
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
