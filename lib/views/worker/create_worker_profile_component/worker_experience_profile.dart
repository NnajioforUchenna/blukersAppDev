import 'package:bulkers/models/work_experience.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/providers/worker_provider.dart';
import 'package:bulkers/utils/styles/theme_colors.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/worker/create_worker_profile_component/work_experience_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkerExperienceProfile extends StatelessWidget {
  const WorkerExperienceProfile({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          ...wp.workExperience
              .map((e) =>
                  WorkExperienceForm(index: wp.workExperience.indexOf(e)))
              .toList(),
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
                    jobStartDate: wp.workExperience[i]["jobStartDate"],
                    jobEndDate: wp.workExperience[i]["jobEndDate"],
                    isCurrentlyWorking:
                        wp.workExperience[i]["isCurrentlyWorking"] ?? false));
              }
              up.appUser!.worker!.workExperiences = ref;
              await up.updateWorkerInfo(up.appUser!.worker!);
              Navigator.of(context).pop();
              print(wp.workExperience);
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                  color: ThemeColors.primaryThemeColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                "Update",
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