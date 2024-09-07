import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../models/work_experience.dart';
import '../../../../../providers/user_provider_parts/user_provider.dart';
import '../../../../../utils/styles/theme_colors.dart';
import '../../../../../utils/styles/theme_text_styles.dart';
import 'work_experience/work_experience_form.dart';

class WorkerExperienceProfile extends StatelessWidget {
  const WorkerExperienceProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // WorkersProvider wp = Provider.of<WorkersProvider>(context);
    CreateWorkerProfileProvider wp =
        Provider.of<CreateWorkerProfileProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          ...wp.workExperience.map(
              (e) => WorkExperienceForm(index: wp.workExperience.indexOf(e))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  wp.addNewReference();
                },
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      color: ThemeColors.primaryThemeColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "+",
                    style: ThemeTextStyles
                        .informationDisplayPlaceHolderThemeTextStyle
                        .apply(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              List<WorkExperience> ref = [];
              for (int i = 0; i < wp.workExperience.length; ++i) {
                ref.add(WorkExperience(
                    companyName: wp.workExperience[i]["companyName"],
                    jobTitle: wp.workExperience[i]["jobTitle"],
                    jobDescription: wp.workExperience[i]["jobDescription"],
                    jobStartDate:
                        DateTime.parse(wp.workExperience[i]["jobStartDate"]),
                    jobEndDate: wp.workExperience[i]["isCurrentlyWorking"]
                        ? null
                        : DateTime.parse(wp.workExperience[i]["jobEndDate"]),
                    isCurrentlyWorking:
                        wp.workExperience[i]["isCurrentlyWorking"] ?? false));
              }
              up.appUser!.workerResumeDetails?.workExperiences = ref;
              // await up.updateWorkerInfo(up.appUser!.worker!);
              Navigator.of(context).pop();
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                  color: ThemeColors.primaryThemeColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                AppLocalizations.of(context)!.update,
                style: ThemeTextStyles
                    .informationDisplayPlaceHolderThemeTextStyle
                    .apply(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
