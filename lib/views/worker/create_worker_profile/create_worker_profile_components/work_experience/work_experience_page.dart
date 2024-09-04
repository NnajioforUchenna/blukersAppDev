import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../../services/responsive.dart';
import '../timeline_navigation_button.dart';
import 'work_experience_form.dart';

class WorkExperiencePage extends StatefulWidget {
  const WorkExperiencePage({super.key});

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage> {
  @override
  Widget build(BuildContext context) {
    CreateWorkerProfileProvider cwpp =
        Provider.of<CreateWorkerProfileProvider>(context);
    List<WorkExperienceForm> workExperienceForms = [];
      for (int i = 0; i < cwpp.workExperience.length; i++) {
        workExperienceForms.add(WorkExperienceForm(index: i));
      }
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
           ...workExperienceForms,
            Tooltip(
              message: AppLocalizations.of(context)!.addMoreWorkExperience,
              child: InkWell(
                onTap: () {
                  cwpp.addWorkExperience();
                },
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        cwpp.addWorkExperience();
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.addMoreWorkExperience,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
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
                    FocusScope.of(context).unfocus();
                    cwpp.setWorkExperience();
                  },
                ),
              ],
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
