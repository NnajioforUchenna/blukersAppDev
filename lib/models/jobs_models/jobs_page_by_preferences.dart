import 'package:blukers/models/app_user/components/preference.dart';

import '../job_post.dart';

class JobsPageByPreferences {
  int pageNumJobsByPreferences;
  Preference? preference;
  List<JobPost> jobs;
  String language = 'en';

  JobsPageByPreferences({
    this.pageNumJobsByPreferences = 0,
    this.preference,
    List<JobPost>? jobs,
    this.language = 'en',
  }) : jobs = jobs ?? [];

  String? getSearchParameter() {
    // Check if the preference and jobIds are not null, and flatten jobIds map into a list of strings
    if (preference != null && preference!.jobIds.isNotEmpty) {
      return preference?.jobIds.values
          .expand((jobIdList) =>
              jobIdList) // Flatten the lists into a single iterable
          .join(','); // Join all job IDs with a comma
    }
    return '';
  }
}
