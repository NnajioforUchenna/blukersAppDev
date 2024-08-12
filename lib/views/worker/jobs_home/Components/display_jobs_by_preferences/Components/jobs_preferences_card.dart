import 'package:blukers/models/app_user/components/preference.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/common_vieiws/loading_page.dart';
import 'package:blukers/views/worker/jobs_home/Components/display_jobs_by_preferences/Components/grey_container_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class JobsPreferencesCard extends StatelessWidget {
  const JobsPreferencesCard({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    Preference? preference = up.appUser?.registrationDetails?.jobsPreference;

    if (preference == null) {
      return const LoadingPage();
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Your Jobs Preferences",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.blukersOrangeThemeColor),
              ),
              IconButton(
                  onPressed: () {
                    // Add your edit button logic here
                    context.go('/setJobsPreferences');
                  },
                  icon: const Icon(Icons.edit,
                      color: ThemeColors.blukersBlueThemeColor)),
            ],
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Industry:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.blukersBlueThemeColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: preference.industryIds.map((industryId) {
                            return GreyContainerText(
                              child: Text(
                                industryId,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jobs:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.blukersBlueThemeColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: preference.jobIds.entries.expand((entry) {
                            return entry.value.map((jobId) {
                              return GreyContainerText(
                                child: Text(
                                  jobId,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              );
                            });
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
